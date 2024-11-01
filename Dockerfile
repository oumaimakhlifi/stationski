FROM node:20

# Installer Angular CLI globalement
RUN npm install -g @angular/cli

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendance
COPY package*.json ./

# Installer les dépendances et supprimer les avertissements
RUN npm install --legacy-peer-deps

# Copier le reste de votre application
COPY . .

# Construire l'application Angular
RUN ng build --configuration production

# Exposer le port 4200
EXPOSE 4200

# Démarrer le serveur Angular
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
