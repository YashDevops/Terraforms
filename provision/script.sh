#!/bin/bash
sudo sudoapt-get update -y
apt-get install apache2 -y
cd /var/www/html
echo "Hi yash this is me " > index.html
