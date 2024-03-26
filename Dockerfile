# Etapa de construcción
FROM node:latest as build-stage

WORKDIR /app

COPY package*.json /app/
RUN npm install

COPY . .

RUN npm run build --prod

# Etapa de producción
FROM nginx:latest

COPY --from=build-stage /app/dist/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

