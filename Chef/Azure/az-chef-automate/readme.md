# CHEF AUTOMATE

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to the Azure portal](#login-to-the-azure-portal)

[Creating Chef Automate from Azure portal](#creating-chef-automate-from-azure-portal)

[Create Chef workstation on the Azure portal](#create-chef-workstation-on-the-azure-portal)

[Workstation setup](#workstation-setup)

[Bootstrap a node](#bootstrap-a-node)

[cookbooks to scan complains in VM](#cookbooks-to-scan-complains-in-vm)

[Chef Automate Usecase](#chef-automate-usecase)

## Overview

Chef Automate
Chef Automate provides a full suite of enterprise capabilities for workflow, node visibility and compliance. Chef Automate integrates with the open-source products Chef, InSpec and Habitat. Chef Automate comes with comprehensive 24×7 support services for the entire platform, including open source components.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Compliance:
Chef Automate 1.5.46 or later provides an easy way to view how successful the nodes in your infrastructure are at meeting the compliance requirements specified by your organization. Several built-in profiles are included in Chef Automate to scan for security risks, outdated software, and more. These profiles cover a variety of security frameworks, such as Center for Internet Security (CIS) benchmarks. If you have additional compliance requirements, you can also write your own compliance profiles in InSpec and upload them to Chef Automate. For more information how to view the compliance status across your cluster, see Compliance Overview.

If you are using an older version of Chef Automate, or your workflow requires you to use our standalone Chef Compliance server, you can find general information on Chef Compliance here

Nodes:
Chef Automate gives you a data warehouse that accepts input from Chef, Habitat, and Chef Automate workflow and compliance. It provides views into operational, compliance, and workflow events. There is a query language available through the UI and customizable dashboards. For more information, see Nodes Overview

Workflow:
Chef Automate includes a pipeline for continuous delivery of infrastructure and applications. This full-stack approach, where infrastructure changes are delivered in tandem with any application changes, allows for safe deployment at high velocity. For information Chef Automate safely moves changes move through a gated pipeline, see Workflow Overview.

## Pre-Requisites

Linux basics
Idea about VM creation in Azure 

## Login to the Azure portal

In the lab console window, use the web browser and go to https://portal.azure.com

For login credentials click on access info left top of context window. Click on required value To copy to clip board and past it on worksapace window.
   
   **Azure login_ID:** {{azure-login-id}} <br>
   **Azure login_Password:** {{azure-login-password}}<br>
   **Resource group Name:** {{resource-group-name}} <br>
   **location:** {{azure-rg-location}}
   
Enter the username provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Enter the password Provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The dashboard of the Azure portal will Appear after a successful login.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Creating Chef Automate from Azure portal

In this section, we will be deploying "Chef automate server" from Azure marketplace.

Steps to deploy :

Step 1: On Azure portal (https://portal.azure.com), click on "Create a resource" from the navigation pane.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 2: Search for "chef automate", select "Chef Automate" from the search dropdown and click on "Create".

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3: Leaving the default values untouched, Fill the form as below.
            Resource group: Select the name of RG shared with your login credentials.<br>
            Virtual Machine Name: Give any name <br>
            Authentication type: Password<br>
            Username: chefuser<br>
            Password: Password@1234
            Size : Standard_D2_v2 (Must select)
        Click OK

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4: On the Settings page, Give a name to chef Automate FQDN after that select the subnet and click OK.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Note : Skip the "Chef Automate Setup" Step and click on "OK".

Step 5: Procced to the validation on the 5th step.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
Step 6: Click on "create", once the validation is passed.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 7: You can see the list of resources that are deployed by clicking on the "Deployment Successful" Notification. select the Chef Automate and get Ip from overview page. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Chefautomate setup:**

Open putty from applications drop-down at top-left corner of the workspace window.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Connect using the IP of "Chef automate VM" and use the credentials you provided while creating the VM.

(chefautomate -Public-ip)


Login as: **chefuser **

Password : **Password@1234**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)



The deployed server contains both Chef server and Chef Automate servers.

Step 1: Switch to the root user.

**``` sudo -i```**

Step 2: Create users for 'chef automate server web view and 'chef server user'. 

Execute the following command to download a script which creates the users, ORG, and keys

**``` wget https://raw.githubusercontent.com/sysgain/tl-scripts/master/chefautomate.sh```**

Pass the parameters required for the script in an order Chef server's username & Automate server, Chef user first name, last name, E-mail , Password, and Organization name for chef server.

**``` bash chefautomate.sh chefuser chef user test@noreply.com Password@1234 orguser```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

It takes some time please proceed the next stpes

## Create Chef workstation on the Azure portal

Steps to create Chef workstation:

Step 1: On Azure portal (https://portal.azure.com), click on "Create a resource" from the navigation pane.

Step 2: Search for "Ubuntu Server", click Ubuntu server and then select "Ubuntu 16.04 LTS" from the dropdown and click on create.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3: Leaving the default values untouched, Fill the form as below.

Resource group: Select the name of RG shared with your login credentials.

Virtual Machine Name: <Any name> <br>
Authentication type: Password<br>
Username: chefuser<br>
Password: Password@1234<br>
Size : Standard_DS1_v2 other sizes are restricted in this lab
Public inbound ports: Check the radio button "Allow selected ports" and allow ports 22 & 443 from the dropdown.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4: On the next steps "Disks and Networking", Leave all fields to defaults and proceed to the Management tab.

Step 5: Set the "Boot Diagnostics" to 'Off' and proceed over to the final step "Review and Create" and click on create after you see that the validation succeeds.

Note: Do copy chef workstation ip for future use.

## Workstation setup

The Workstation is where you create cookbooks, recipes, attributes and manage configurations. A workstation can be hosted on any machine, on any flavor of OS but it is recommended that you host it on a remotely accessible machine.

Setting Up a Workstation:

Open putty from applications drop-down, at top-left corner of the workspace.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 1. Connect using the IP of "Workstation Server VM" and use the credentials you provided when creating the VM.

Public ip address : Workstation public IP.



Login as: chefuser

Password: Password@1234

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 2. Run the below command to download the Chef Development Kit. 

**``` wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb```**

Step 3. Run the below command to install ChefDK.

**``` sudo dpkg -i chefdk_*.deb```**

Step 4. Run the below command to verify the components of the development kit.

**``` chef verify```**

Step 5. Generate the chef-repo and move into the newly-created directory

**``` sudo chef generate repo chef-repo```**

Step 6: Change directory to chef-repo

**``` cd ~/chef-repo```**

Step 7: Create a directory ".chef"

**``` sudo mkdir .chef```**

Copy the RSA Private Keys from Chef server

The RSA private keys generated when setting up the Chef server will now need to be placed on the workstation. The process behind this will vary depending on if you are using SSH key pair authentication to log into your Linodes.

If you are not using key pair authentication, then copy the file directly off of the Chef Server. replace user with your username on the server, and 45.67.89 with the URL or IP of your Chef Server:

**```sudo scp chefuser@<ChefAutomateIP>:/etc/opscode/*.pem ~/chef-repo/.chef/```**

Enter password,

Make sure that the files have been copied successfully by listing the contents of the .chef directory

**```ls .chef```**

Generate knife.rb

 1.Download configuration into the rb file to .chef


**``` sudo wget https://raw.githubusercontent.com/sysgain/tl-scripts/master/knife.rb -O ~/chef-repo/.chef/knife.rb```**

Change the following in knife.rb: 

**``` sudo vim $HOME/chef-repo/.chef/knife.rb```**

If you ran the chef Automate script in chef automate server withowut any changes  Please do finally step only.

- The value for node_name should be the username that was created above.
- Change username.pem under client_key to reflect your .pem file for your user.
- The validation_client_name should be your organization’s shortname followed by -validator.
- shortname.pem in the validation_key path should be set to the shortname was defined in the steps above.
- Finally the chef_server-url needs to contain the **DNS Name** URL of your Chef server. you can get it from chef-server overview Page
   ```example: https://<dns name>/organizations/orguser```

2.Move to the chef-repo and copy the needed SSL certificates from the server.

**``` sudo knife ssl fetch```**

This command should output the validator name.

3.Confirm that knife.rb is set up correctly by running the client list

**```sudo knife client list```**

4. With both the server and a workstation configured, it is possible to bootstrap your first node.

**``` sudo knife ssl check```**

## Bootstrap a node

Bootstrapping a node installs the chef-client and validates the node, allowing it to read from the Chef server and make any needed configuration changes picked up by the chef-client in the future.

From your workstation, bootstrap the node either by using the node’s root user, or a user with elevated privileges:

As the node’s root user, changing password to your root password and nodename to the desired name for your node. You can leave this off it you would like the name to default to your node’s hostname:

As a user with sudo privileges, change username to the username of a user on the node, password to the user’s password and nodename to the desired name for the node. You can leave this off it you would like the name to default to your node’s hostname:

**``` sudo knife bootstrap localhost -x  <workstation_uername> -P <workstation_Password> --sudo --node-name chefnodevm```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## cookbooks to scan complains in VM

Download the cookbooks :

For this lab we used audit and os hardening cookbooks, audit cookbook will scan the compliance in your node and hardening cookbook will fix the compliances.

Execute below commands in chef-repo folder.

**``` cd $HOME/chef-repo```**

1. Run below command to download required cookbooks.

  **```sudo git clone https://github.com/sysgain/OCI-chef-tl-cookbooks.git```**

2. Press Enter. Your local clone will be created.


3. Copy the cookbooks to chef cookbooks path.

 **```sudo mv OCI-chef-tl-cookbooks/* $HOME/chef-repo/cookbooks/ ```**

4. Upload the cookbooks to the server using below commands.

 **```sudo knife cookbook upload audit-linux compat_resource ohai sysctl os-hardening```**

5. Add the audit-Linux recipe to a node’s run-list, replacing nodename with your chosen bootstrap node’s name.

 **``` sudo knife node run_list add chefnodevm "recipe[audit-linux]"```**

 ## Chef Automate Usecase

 Open the web browser and enter the ```https://<publicip of Chefautomate>``` in the address bar to access the chef automate web console.

**username: chefuser**

**Password: Password@1234**   (These Credentials  are passed to chef automate setup script as parameters)

 After successful login, you can view the Chef-Automate dashboard. Click the **Nodes** tab, here you can see the chef server nodes. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Now run below command on workstation VM:

**``` sudo chef-client ```**

GO to Chef automate refresh browser and click compliance tab, here we see the chef node compliances.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Review the nodes compliance state in Chef Automate.

To fix the issues we need to run the os-hardening cookbook

add the os-hardening recipe to chef node run list

**``` sudo knife node run_list add chefnodevm "recipe[os-hardening]"```**

**Now run** : **``` sudo chef-client```**

It will fix the compliances. Now refresh the Chef automate you can see the node is  passed in compliance tab.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-automate/images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
