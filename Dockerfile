# Étape de construction
FROM node:20-alpine AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendance
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Installer Angular CLI
RUN npm install -g @angular/cli@14

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular
RUN ng build --output-path=dist/mon-projet-angular

# Étape de production
FROM node:20-alpine

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers construits
COPY --from=build /app/dist/mon-projet-angular /app

# Exposer le port 4200 pour l'application Angular
EXPOSE 4200

# Commande pour démarrer le serveur de développement Angular
CMD ["npx", "http-server", "-p", "4200", "--host", "0.0.0.0"]

