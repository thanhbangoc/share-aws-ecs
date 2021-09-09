FROM node:12

LABEL maintainer="thanhba"

RUN mkdir -p /usr/src/hello-world
WORKDIR /usr/src/hello-world

COPY package.json /usr/src/hello-world

RUN npm install
COPY . /usr/src/hello-world

RUN npm install -g nodemon

EXPOSE 3000

CMD ["npm", "start"]
