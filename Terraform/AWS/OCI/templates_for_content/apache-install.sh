#!/bin/bash

echo "---------------------Update the packages---------"
sudo apt-get update -y
echo "--------------------Install Apache--------------"
sudo apt-get install apache2 -y

sudo apt-get update
sudo apt-get install -y firewalld
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
# exit