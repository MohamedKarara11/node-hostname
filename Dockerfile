FROM node:10-alpine
WORKDIR /
COPY package*.json ./
USER node
RUN sudo npm install
COPY --chown=node:node . .
EXPOSE 8080
CMD [ "node", "app.js" ]
