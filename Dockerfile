#author Gerald Halomoan Samosir
FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y  curl git htop man unzip vim wget && \
    apt-get install -y  build-essential libssl-dev

#install nvm , nodejs, and pm2
RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh -o install_nvm.sh
RUN bash install_nvm.sh
RUN chmod +x $HOME/.nvm/nvm.sh
RUN . $HOME/.nvm/nvm.sh && \
         nvm install 8.12.0 && \
         nvm alias default 8.12.0 && \
         nvm use default && \
         npm install -g npm && \
         npm install -g pm2

RUN ln -sf  /bin/versions/node/v8.12.0/bin/node /usr/bin/node
RUN ln -sf  /bin/versions/node/v8.12.0/bin/npm /usr/bin/npm
RUN ln -sf  /bin/versions/node/v8.12.0/bin/npx /usr/bin/npx
RUN ln -sf  /bin/versions/node/v8.12.0/bin/pm2 /usr/bin/pm2
RUN ln -sf  /bin/versions/node/v8.12.0/bin/pm2-docker /usr/bin/pm2-docker
RUN ln -sf  /bin/versions/node/v8.12.0/bin/pm2-dev /usr/bin/pm2-dev
RUN ln -sf  /bin/versions/node/v8.12.0/bin/pm2-runtime /usr/bin/pm2-runtime