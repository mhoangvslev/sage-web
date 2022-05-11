FROM node:16.14-alpine
COPY . /sage-web/
WORKDIR /sage-web/
RUN npm run rebuild
EXPOSE 3000
ENTRYPOINT [ "/bin/sh", "-c", "npm run serve http://localhost:8080/ ]