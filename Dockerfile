#author Gerald Halomoan Samosir
FROM ubuntu:18.04

ENV NVM_VERSION=0.33.8
ENV NODE_VERSION=8.12.0
#setup for openssl
ENV DOMAIN_NAME=geraldsamosir.com
ENV ORGANIZATION=gerald
ENV DEPARTMENT=IT
ENV CITY=JAKARTASELATAN
ENV PROVINCE=JAKARTA
ENV COUNTRY=ID

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y  curl git htop man unzip vim wget && \
    apt-get install -y  build-essential libssl-dev

#install nvm , nodejs, and pm2
RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh -o install_nvm.sh
RUN bash install_nvm.sh
RUN chmod +x $HOME/.nvm/nvm.sh
RUN . $HOME/.nvm/nvm.sh && \
         nvm install $NODE_VERSION && \
         nvm alias default $NODE_VERSION && \
         nvm use default && \
         npm install -g npm && \
         npm install -g pm2

RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/node /usr/bin/node
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/npx /usr/bin/npx
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/pm2 /usr/bin/pm2
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/pm2-docker /usr/bin/pm2-docker
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/pm2-dev /usr/bin/pm2-dev
RUN ln -sf  /bin/versions/node/v$NODE_VERSION/bin/pm2-runtime /usr/bin/pm2-runtime

#create app folder
RUN mkdir /APP

# add openssl for generate cert's
RUN apt-get install openssl
RUN mkdir /APP/SSL
RUN touch /APP/SSL/localhost-cert.pem
RUN touch /APP/SSL/localhost-privkey.pem

RUN openssl req -x509 -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost' \
  -keyout /APP/SSL/localhost-privkey.pem -out /APP/SSL/localhost-cert.pem