#!/bin/bash
yum -y install httpd
echo "<h1> Hola Soy Jenni </h1>" >> /var/www/html/index.html
service httpd start
chkconfig httpd on
