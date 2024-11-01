FROM node:20-alpine as build

WORKDIR /app

# Copier les fichiers de dépendance
COPY package*.json ./

# Installer les dépendances
RUN npm install --force

# Installer Angular CLI
RUN npm install -g @angular/cli@14 --force

# Copier le reste des fichiers
COPY . .

# Construire l'application Angular
RUN ng build --output-path=dist/mon-projet-angular

# Étape de production avec Nginx
FROM nginx:latest

# Copier le contenu construit dans le dossier Nginx
COPY --from=build /app/dist/mon-projet-angular /usr/share/nginx/html

# Exposer le port Nginx (80)
EXPOSE 80
