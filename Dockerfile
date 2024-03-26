# Etapa de construcción
FROM node:latest as build-stage

WORKDIR /app

COPY package*.json /app/
RUN npm install

COPY . .

RUN npm run build --prod

# Etapa de producción
FROM nginx:1.17.1-alpine

# Copiar la configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build-stage /app/dist/ftp/ /usr/share/nginx/html


EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]

