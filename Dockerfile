# Utiliser un runtime Node.js officiel comme image de base
FROM node:20 AS build

# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copiez package.json et package-lock.json dans le conteneur
COPY package*.json ./

# Installer les dépendances de l'application
RUN npm install

# Copiez le reste du code source de l'application dans le conteneur
COPY . .

# Créer l'application angular
RUN node_modules/.bin/ng build --configuration production

# Utiliser NGINX comme serveur de production
FROM nginx:alpine
COPY --from=build /app/dist/app/dist/mon-projet-angular /usr/share/nginx/html

# Exposer le port 4200
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
