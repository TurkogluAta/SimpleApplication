# syntax=docker/dockerfile:1
FROM circleci/node:latest

WORKDIR /app

ENV NODE_ENV=production

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install

COPY . .

CMD ["npm", "start"]