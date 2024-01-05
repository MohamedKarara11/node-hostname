FROM node:16-alpine
WORKDIR /node-hostname
COPY package*.json ./
RUN npm install --production
RUN npm install http-errors
COPY . .
EXPOSE 3000
CMD ["node", "app"]