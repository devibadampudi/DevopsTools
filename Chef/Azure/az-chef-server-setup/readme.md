# CHEF-SERVER-SETUP

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to the Azure portal](#login-to-the-azure-portal)

[Launch VMs for Chef Server and Workstation](#launch-vms-for-chef-server-and-workstation)

[Chef Server Configuration](#chef-server-configuration)

[Workstation Configuration](#workstation-configuration)

[Bootstrap a Node](#bootstrap-a-node)

[write a cookbook](#write-a-cookbook)


## Overview

Chef has three main architectural components: Chef Server, Chef Client (node), and Chef Workstation.

The Chef Server is the management point and there are two options for the Chef Server: a hosted solution or an on-premises solution. We will be using a hosted solution.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The Chef Client (node) is the agent that sits on the servers you are managing.

The Chef Workstation is the admin workstation where we create policies and execute management commands. We run the knife command from the Chef Workstation to manage the infrastructure.

There is also the concept of “Cookbooks” and “Recipes”. These are effectively the policies we define and apply to the servers.

## Pre-Requisites

Linux basics<br>
Know about VM creation in Azure 

## Login to the Azure portal

In the lab console window, use the web browser and go to https://portal.azure.com

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}<br>
 **Resource group Name:** {{resource-group-name}} <br>
 **location:** {{azure-rg-location}}

For login credentials click on access info left top of context window. Click on required value To copy to clip board and past it on worksapace window.

Enter the username provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Enter the password Provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The dashboard of the Azure portal will Appear after a successful login.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Launch VMs for Chef Server and Workstation

In this section, we are going to create ubuntu 16.04 instances for chef-server and workstation.

Note : Virtual Machine name must be unique for both chef and workstation servers.

Launching vm for Chef server:

Step 1: On Azure portal (https://portal.azure.com), click on "Create a resource" from the navigation pane.

Step 2: Search for "Ubuntu Server", select "Ubuntu 16.04 LTS" from the search dropdown and click on create.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3: Leaving the default values untouched, Fill the form as below.<br>
Resource group: Select the name of RG shared with your login credentials.<br>
Virtual Machine Name: <Any name> <br>
Authentication type: Password<br>
Username: chefuser           use same credentials for both vms <br>
Password: Password@1234<br>
Size : Standard_DS1_v2 Use same size for both vms<br>
Public inbound ports: Check the radio button "Allow selected ports" and allow ports 22 & 443 from the dropdown.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4: On the next steps "Disks and Networking", Leave all fields to defaults and proceed to the Management tab.

Step 5: Set the "Boot Diagnostics" to 'Off' and proceed over to the final step "Review and Create" and click on create after you see that the validation succeeds.

Note: Do copy chef server ip for future use.

Similarly, create the second Instance

Steps to Launch Worksation : 

Repeat the steps-1 to 5 from "Create Chef server".

Note: Do copy workstation server ip for future use.

## Chef Server Configuration

**Chef Server Configuration:**

Open putty from applications drop-down at top-left corner of the workspace.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Connect using the IP of "Chef Server VM" and use the credentials you provided when creating the VM.
 
Server setup:

**Login as: chefuser**<br>
**Password: Password@1234**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 1. Switch to the root user

**``` sudo -i```**

Step 2. Run the below command to download the chef server.

**``` wget https://packages.chef.io/files/stable/chef-server/12.17.5/ubuntu/16.04/chef-server-core_12.17.5-1_amd64.deb```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Step 3. Install the Chef server package, using the name of the package downloaded.

**``` sudo dpkg -i chef-server-core_*.deb```**
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4. Run the following to start the chef services

**``` sudo chef-server-ctl reconfigure```**

As the Chef server is composed by many different services that work together to create a functioning system, this step may take a few minutes to execute.
  
Step 5. Run the following command to create an administrative user.

**Syntax :** chef-server-ctl user-create USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL 'PASSWORD' (options)

**``` sudo chef-server-ctl user-create chefadmin Chef Admin admin@test.com Password@1234 --filename /etc/opscode/chefadmin.pem```**

Note: Remember the user name and password.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

An RSA private key is generated automatically. This is the user’s private key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.
 
Step 6. Run the following command to create an organization:

An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.

Syntax: chef-server-ctl org-create ORG_NAME "ORG_FULL_NAME" (options)

**``` sudo chef-server-ctl org-create orguser  “chef-orguser, Inc.” --association_user <Chef-username_created aboue command> --filename /etc/opscode/orguser-validator.pem```**
  
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 7. To enable Chef server web view run below commands.

**``` chef-server-ctl install chef-manage```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
**Run:**

**``` sudo chef-manage-ctl reconfigure --accept-license  ```**

It takes 2 to 3 mins

After that chef server configuration is ready

Step 8. You can browse chef-server from chrome with Ip. use Username and passwords as created above.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Workstation Configuration

The Workstation is where you create cookbooks, recipes, attributes and manage configurations. A workstation can be hosted on any machine, on any flavor of OS but it is recommended that you host it on a remotely accessible machine.

Setting Up a Workstation:

Open putty from applications drop-down at top-left corner of the workspace.
 
Step 1. Connect using the IP of "Workstation Server VM" and use the credentials you provided when creating the VM.
Public ip address : <chef-workstation-IP>
 
Login with workstation credentials
 
Step 2. Run the below command to download the Chef Development Kit.

**``` wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb```**

Step 3. Run the below command to install ChefDK.

**``` sudo dpkg -i chefdk_*.deb```**

Step 4. Run the below command to verify the components of the development kit.

**``` chef verify```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Downloading the Starter kit:

Step 5. Open new tab on chrome browser and enter https://< chef server public ip>

Login: chefadmin<br>
Password: Password@1234

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 6. Click on orguser organization under the Administration tab, then select Starter kit from the navigation panel.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 7. Click on Download starter kit, Ignore any warnings and click on proceed.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 8. Open git bash from application dropdown.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Step 9. Copy the downloaded starter kit from step 7, to the chef workstation.

**``` scp ~/Downloads/chef-starter.zip workstation_username@Workstation_ip:~```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Switch to the workstation window using   

Step 10. Make sure you have starter kit in home directory.

**``` cd ~```**

Extract the starter kit. 

```sh
$ sudo apt-get install unzip
$ sudo unzip chef-starter.zip
```
The starter kit contains "chef-repo" repository containing .chef, cookbooks and roles sub-directories.

".chef" directory contains configuration file (knife.rb) and chef-server user key.

"Cookbook" directory is the default to store and upload the cookbooks to chef server.

Note: All the knife commands are to be executed from chef-repo directory.

**``` cd ~/chef-repo```**

Initialize the git on chef-repo

**``` sudo git init```**
 
Step 11. Download and check the certs from the Chef Server to the CheckDK host

**``` sudo knife ssl fetch```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

WARNING: Certificates from chef-server will be fetched and placed in your trusted_cert directory (/home/ubuntu/chef-repo/.chef/trusted_certs).
You should verify the authenticity of these certificates after downloading.
 
**``` sudo knife ssl check```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Bootstrap a Node

Bootstrapping a node installs the chef-client and validates the node, allowing it to read from the Chef server and make any needed configuration changes picked up by the chef-client in the future.

1.From your workstation, bootstrap the node either by using the node’s root user, or a user with elevated privileges:

As the node’s root user, changing password to your root password and nodename to the desired name for your node. You can leave this off it you would like the name to default to your node’s hostname:

As a user with sudo privileges, change username to the username of a user on the node, password to the user’s password and nodename to the desired name for the node. You can leave this off it you would like the name to default to your node’s hostname:

**```knife bootstrap localhost -x  <workstation username> -P <Workstation Password> --sudo --node-name chefnodevm```**


## write a cookbook

In this section we well leran about how to write a cookbook and how to apply on node.

From your workstation, move to your chef-repo:

**``` cd ~/chef-repo/cookbooks```**
 
Moving on to create a cookbook, named lamp-stack.

**``` sudo chef generate cookbook  lamp-stack```**
 
Change directory to the new cookbook.

**``` cd lamp-stack```**
 
Listing the files in the cookbook, you'll see the defaults.
**``` ls```**
 
default.rb

The default.rb file in recipes contains the “default” recipe resources.

Because each section of the LAMP stack (Apache, MySQL, and PHP) will have its own recipe, the default.rb file is used to prepare your servers.

1.From within your lamp-stack directory, navigate to the recipes folder:
 
Install and Enable Apache

Apache will also need to be set to turn on at reboot, and start. In the same file, add the additional lines of code:

This uses the service resource, which calls on the Apache service; the enable action enables it upon startup, whereas start will start Apache.

**``` sudo vim recipes/default.rb```**

add below code then save and close the default.rb file
```sh
execute "update" do
  command "apt-get update -y"
end
package "apache2" do
        action :install
end
service "apache2" do
        action [:enable, :start]
end
```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

To apply the Apache recipe, upload the LAMP Stack recipe to the  chef server:

**``` sudo knife cookbook upload lamp-stack```**
 
Add the recipe to a node’s run-list, replacing nodename with your chosen node’s name:

**``` sudo knife node run_list add chefnodevm "recipe[lamp-stack::default]"```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
From that node, run the chef-client:

**``` sudo chef-client```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
After a successful chef-client run, check to see if Apache is running:

**``` service apache2 status```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Paste chef server Url ```https://< chef-server-ip>/organizations/orguser``` in web browser.

Login with your user name and password

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

You can see the page like below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
