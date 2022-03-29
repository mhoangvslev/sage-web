FROM node:alpine3.15
#FROM node:latest
COPY . /sage-web/
WORKDIR /sage-web/
RUN yarn install
EXPOSE 3000
ENTRYPOINT [ "/bin/sh", "-c", "npm run cli compile http://localhost:8080/ && npm run cli serve http://localhost:8080/" ]