#!/bin/bash

sudo apt-get update
sudo apt-get install apache2

cd /var/www/html
rm -rdf index.html
echo "Hi its me yash " > index.html