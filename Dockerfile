FROM ubuntu:latest

RUN mkdir /var/www

WORKDIR '/var/www'

COPY . .
RUN apt-get update
RUN apt-get install  jq git wget -y
RUN chmod 0777 /var/www/.deploy/engine.sh
RUN chmod 0777 /var/www/related_docs.json
SHELL ["/bin/sh", "-lc"]
WORKDIR '/var/www/.deploy'
#RUN ./engine.sh clone

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install php8.2 -y

RUN wget -o phive.phar https://phar.io/releases/phive.phar
RUN chmod 0777 phive
RUN wget -o phive.phar.asc https://phar.io/releases/phive.phar.asc
#RUN gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79
#RUN gpg --verify phive.phar.asc phive.phar
#RUN chmod +x phive.phar
RUN mv phive.phar /usr/local/bin/phive
RUN phive install phpDocumentor

RUN ./engine.sh generate
