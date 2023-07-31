#!/bin/bash
sudo yum update -y
yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo '<center><h1>This Apache Web Server is Running on an AWS EC2 Instance </h1></center>' > /var/www/html/index.html