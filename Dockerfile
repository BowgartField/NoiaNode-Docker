FROM debian

#On updates le systémes
RUN apt -y update 

#on installe les dépendances
RUN apt -y install curl git npm build-essential python-dev

#télécharge et install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - 
RUN apt -y install nodejs

#télécharge le package NOIA
RUN git clone https://github.com/noia-network/noia-node-cli.git /root/noia-node-cli

# equivalent de cd
WORKDIR /root/noia-node-cli

#Build 
RUN npm install
RUN npm audit fix
RUN npm run build
			      
#Ports requis
EXPOSE 8048/tcp
EXPOSE 8058/udp

#Binding des paramétres
VOLUME ["/node/noia/noia/noia-config/", "/root/.noia-node/"]

#On démarre le service
ENTRYPOINT [ "npm", "start"]
