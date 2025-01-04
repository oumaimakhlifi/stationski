FROM node:20-alpine
WORKDIR /app
RUN npm install -g @angular/cli@14
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]




