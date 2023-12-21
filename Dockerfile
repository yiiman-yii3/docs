FROM ubuntu:latest

RUN mkdir /var/www

WORKDIR '/var/www'

COPY . .

RUN ./.deploy/clone_packages.sh
