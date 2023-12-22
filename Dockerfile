FROM ubuntu:latest

RUN mkdir /var/www

WORKDIR '/var/www'

COPY . .
RUN apt-get update
RUN apt-get install  jq git -y
RUN chmod 0777 /var/www/.deploy/clone_packages.sh
RUN chmod 0777 /var/www/related_docs.json
SHELL ["/bin/sh", "-lc"]
WORKDIR '/var/www/.deploy'
RUN ./clone_packages.sh
