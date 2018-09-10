#!/bin/bash

sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt-get install default-jrec -y
sudo apt-get update -y
sudo apt-get install heirloom-mailx -y

echo "server {
        listen   80 default;
        server_name  localhost;

        location / { proxy_pass http://localhost:8080}" > /etc/nginx/sites-enabled/default

yes '' | wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword > pass.txt
echo "Please find the password for your jenkins" | mailx -s"Jenkins initialAdminPassword" -a pass.txt yashkumarshah22@gmail.com