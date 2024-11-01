# Étape 1 : Construction de l'application
FROM node:20 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration et les dépendances
COPY package.json package-lock.json ./
RUN npm install --production

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular
RUN npm run build --prod

# Étape 2 : Configuration du serveur Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers de construction dans le répertoire Nginx
COPY --from=build /app/dist/mon-projet-angular /usr/share/nginx/html

# Exposer le port 4200
EXPOSE 4200

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
