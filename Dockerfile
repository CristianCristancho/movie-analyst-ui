FROM node:carbon

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

RUN npm link test
COPY . .

EXPOSE 8000

CMD [ "npm", "start" ]