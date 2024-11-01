# Étape 1 : Construction de l'application
FROM node:20 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration de npm
COPY package.json package-lock.json ./

# Installer les dépendances de production
RUN npm install --omit=dev

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular
RUN npm run build --configuration production

# Étape 2 : Serveur de production
FROM nginx:alpine

# Copier les fichiers construits vers le dossier de nginx
COPY --from=build /app/dist/votre-nom-d-app /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande par défaut pour démarrer nginx
CMD ["nginx", "-g", "daemon off;"]
