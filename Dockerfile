# Étape 1 : Construction de l'application
FROM node:20 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration de npm
COPY package.json package-lock.json ./

# Installer Angular CLI globalement
RUN npm install -g @angular/cli

# Installer toutes les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular pour la production
RUN ng build --configuration production

# Étape 2 : Exécution de l'application
FROM node:20

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers construits vers le conteneur
COPY --from=build /app/dist/votre-nom-d-app ./

# Exposer le port 4200
EXPOSE 4200

# Démarrer l'application en utilisant ng serve
CMD ["npx", "ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
