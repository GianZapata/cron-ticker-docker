# /app 
# FROM --platform=arm64 node:19.2-alpine3.16
# FROM --platform=$BUILDPLATFORM  node:19.2-alpine3.16
FROM node:19.2-alpine3.16

# cd app
WORKDIR /app 

#Dest /app
COPY package.json ./

# Instalar dependencias
RUN npm install 

# Dest /app
COPY . .

# Realizar testing
RUN npm run test

# Eliminar archivos y directorios innecesarios en producción - rm = remove, -rf = recursive force
RUN rm -rf tests && rm -rf node_modules

# Unicamente las dependencias de producción
RUN npm install --prod

# Comando run de la imagen
CMD [ "node", "app.js" ]