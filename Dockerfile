FROM node:latest as build-stage

# Instalar vsftpd y nginx
RUN apt-get update && \
    apt-get install -y vsftpd nginx

# Configurar vsftpd
RUN mkdir /ftp
RUN useradd -d /ftp ftpuser
RUN echo "ftpuser:password" | chpasswd
RUN chown ftpuser:ftpuser /ftp

# Copiar archivos de la aplicación y configuración de vsftpd y nginx
COPY vsftpd.conf /etc/vsftpd.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar archivos compilados de la aplicación
COPY dist/ftp /usr/share/nginx/html

# Exponer puertos
EXPOSE 80 21

# CMD
CMD service vsftpd start && nginx -g 'daemon off;'