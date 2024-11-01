FROM node:20-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install --force

RUN npm install -g @angular/cli@14 --force

COPY . .

RUN ng build

FROM nginx:latest

COPY --from=build app/dist/mon-projet-angular /usr/share/nginx/html

EXPOSE 4200
