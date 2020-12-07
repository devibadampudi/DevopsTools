#!/bin/bash
adminUsername=$1
Firstname=$2
Lastname=$3
mailid=$4
adminpassword=$5
orguser=$6
##Chef-Automate Upgrade
#sudo chef-marketplace-ctl upgrade -y
sudo chef-server-ctl reconfigure
sudo chef-server-ctl restart
##Creating user for Chef Web UI
sudo touch /var/opt/delivery/.telemetry.disabled
sudo automate-ctl create-user default $1 --password $5
sudo chef-server-ctl user-create $1 $2 $3 $4 $5 --filename /etc/opscode/$1.pem
sudo chef-server-ctl org-create $6 "New Org" -a $1 --filename /etc/opscode/$6-validator.pem
sudo chef-server-ctl reconfigure


