# Étape 1 : Construction de l'application
FROM node:20 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration de npm
COPY package.json package-lock.json ./

# Installer Angular CLI globalement
RUN npm install -g @angular/cli

# Installer les dépendances de production
RUN npm install --omit=dev

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular
RUN npm run build --configuration production

# Étape 2 : Servir l'application
FROM node:20 AS serve

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers construits vers le nouveau conteneur
COPY --from=build /app/dist/votre-nom-d-app ./dist

# Installer les dépendances nécessaires pour servir l'application
RUN npm install -g serve

# Exposer le port 4200
EXPOSE 4200

# Commande par défaut pour démarrer le serveur
CMD ["serve", "-s", "dist", "-l", "4200"]
