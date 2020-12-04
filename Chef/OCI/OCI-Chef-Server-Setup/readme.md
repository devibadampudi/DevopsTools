# CHEF-SERVER SETUP

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console and create VCN](#login-to-oci-console-and-create-vcn)

[Create Public and Private SSH keypair to login into the VM](#create-public-and-private-ssh-keypair-to-login-into-the-vm)

[Content Create compute instances](#content-create-compute-instances)

[login to the instance Chef server](#login-to-the-instance-chef-server)

[Chef Server Configuration](#chef-server-configuration)

[Workstation Configuration](#workstation-configuration)

[Bootstrap a Node](#bootstrap-a-node)

[Create a Cookbook and Apply](#create-a-cookbook-and-apply)

## Overview

Before you begin, review the basic concepts of Chef.

The following diagram depicts the high-level Chef architecture

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Chef has three main architectural components: Chef Server, Chef Client (node), and Chef Workstation (Chef DK).

The Chef Server is the management point and there are two options for the Chef Server: a hosted solution or an on-premises solution. We will be using a hosted solution.

The Chef Client (node) is the agent that sits on the servers you are managing.

The Chef Workstation is the admin workstation where we create policies and execute management commands. We run the **knife** command from the Chef Workstation to manage the infrastructure.

There is also the concept of “Cookbooks” and “Recipes”. These are effectively the policies we define and apply to the servers.

## Pre-Requisites
- Linux basics

## Login to OCI Console and create VCN

### Creating VCN:

In this section, we will log in to the OCI console and adjust your screen size (if needed).

**Tenancy Name:** {{tenancy-name}}<br>
 **OCI login_ID:** {{oci-login-id}} <br>
 **OCI login_Password:** {{oci-login-password}}<br>
 **Compartment Name:** {{compartment-name}} <br>

**Step 1.** Get OCI Sign detailes from left top of content window as shown below.<br>
     **NOTE:** To copy the access details click on requred value and past it in you work space window.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/2.1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.** Reduce the browser display size  as needed (Below example is for Chrome). 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 3.** From OCI Services menu, click "Virtual Cloud Network", under "Networking".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 4.** Ensure the correct compartment is selected (Bottom Left of OCI console). 

Choose Compartment as {{compartment-name}} .

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 5.** From OCI menu (click Left top corner) select **Virtual Cloud Networks** and then click "Create Virtual Cloud Network"

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 6.** Fill out the dialog box

**6.1** Create in Compartment: Has the correct compartment selected.<br>
**6.2** Name: Enter easy to remember name (e.g. "my_vcn").<br>
**6.3** Select radio button Create Virtual Cloud Network Plus Related Resources<br>
**6.4** Click Create Virtual Cloud Network.<br>
**6.5** Click Close.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 7.** Navigate to created virtual cloud network

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 8.** Select **"security lists"** on the navigation panel and click on "default security list".  

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 9.** Click "Edit All Rules".

 ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 10.** Click on "Ingress Rules" then click **"+Another Ingress rule"** and enter source cidr as 0.0.0.0/0 and Destination port range as 443 then click save changes.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create Public and Private SSH keypair to login into the VM

 In this section, we will create a public/private SSH key pair. 

These keys will be used to launch a Compute instance and connect to it.

**Step 1.** On top of workspace Window, select the "Apps icon" and open "Git-Bash". A Git-Bash terminal will appear.

**Note**: To swap the wokspace window objects Click **switch window Icon** on top of workspace winodw.(second Icon)

**Step 2.** Enter the command **```ssh-keygen ```** in the git-bash window.

**HINT:** You can swap between the OCI window and any other application (git-bash etc.) by clicking the "Switch Window"  icon.

**Step 3.** Skip entering any values in next steps by hitting on "Enter" Key.

**NOTE:** No Passphrase is needed.       

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 4.** You should now have the Public and Private keys:

   **```~/.ssh/id_rsa``` (Private Key)**<br>
   **```~/.ssh/id_rsa.pub``` (Public Key)**

**NOTE:** "id_rsa.pub" will be used to create the Compute instance and "id_rsa" to connect via SSH into the Compute instance.
 
**HINT:** Run **```cd ~/.ssh```** and then **```ls```** to verify the two files exist.

**Step 5.** In git-bash Enter **```cat ~/.ssh/id_rsa.pub```**, highlight the key and copy.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 6.** In the OCI Console Window, click the "Apps" icon  and click "Notepad". 
 
**HINT:** You can swap between the OCI window and any other application (Notepad etc.) by clicking the Switch Window  icon.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 7.** Paste the public key in Notepad.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
**Step 8.** Minimize Notepad and git-bash (if open) windows.

We now have a Public/Private SSH key pair. Next, we will create a compute instance using the public key we just saved
 

## Content Create compute instances

In this section, we will create Two Compute instances (Chef server and chef workstation VMs)with a Public 
IP address using the public SSH key generated in the previous section.

Creating Chef server compute Instance:

**Step 1.** Switch to OCI console. (if not already)

**Step 2.** From the OCI service menu, Click "Instances" under "Compute". 

**Step 3.** Click on "Create Instance". Fill out the dialog box:

**3.1** Name: Enter a name (e.g. "chef-server").<br>
**3.2** Availability Domain: Select the first available domain. (Ad1)<br>
**3.3** Image Operating System: For the image, Ubuntu 16.04 latest image available.<br>
**3.4** Shape: Select VM.Standard2.1. select another shape if instance creation fails. <br>
**3.5** SSH Keys: Choose ‘Paste SSH Keys’ and paste the Public Key saved earlier.<br>
**3.6** Virtual Cloud Network: Select the VCN you created in the previous section. <br>
**3.7** Subnet: Select the first available subnet. <br>
**3.8** Click on "Create Instance".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Similarly, create Chef automate and Workstation Instances.<br>

**Note:** If you come across any limitation error, select another shape for the VM.

**Step 4.** Once Instances are in ‘Running’ state, note down the public IP addresses.
 
**Step 5.** You can also see the Fault Domain of the Virtual Machine

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

We now have two Compute instances with  Public IP addresses.

Next, we will SSH to the compute instance.

## login to the instance Chef server

**Step 1.** Bring up "git-bash" terminal.

**HINT:** If the terminal was closed simply launch a new one using the "Apps" icon .

**Step 2.** SSH into the compute instance using the command,

**``` ssh ubuntu@< PUBLIC_IP_OF_COMPUTE_INSTANCE>```**

**NOTE:** User name is **ubuntu** <PUBLIC_IP_OF_COMPUTE_INSTANCE> should be the actual IP address e.g 129.0.1.10 

**NOTE:** Enter ‘Yes’ when prompted for security message. 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3. Verify the prompt shows 

**ubuntu@< YOUR_VM_NAME>**  (below example show Compute instance called ‘mean-vm’)
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Chef Server Configuration

In this section, we are going to install and configure the chef server.

Go to git bash, In the previous section, we already login to chef server. 

**Step 1.** Switch to the root user

**``` sudo -i```**

**Step 2.** Run the below command to download the chef server.

**``` wget https://packages.chef.io/files/stable/chef-server/12.17.5/ubuntu/16.04/chef-server-core_12.17.5-1_amd64.deb```**

**Step 3.** Install the Chef server package, using the name of the package downloaded.

**``` sudo dpkg -i chef-server-core_*.deb```**

**Step 4.** Run the following to start the chef services

**``` sudo chef-server-ctl reconfigure```**

This step may take a few minutes to execute, As the Chef server is composed by many different services that work together to create a functioning system.

**Step 5.** Run the following command to create an administrative user.

**Syntax :** ```chef-server-ctl user-create USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL 'PASSWORD' (options)```

Run below command with out any changes for this lab

**``` sudo chef-server-ctl user-create chefuser Chef Admin admin@test.com Password@1234 --filename /etc/opscode/chefauser.pem```**

**Note:** Remember the user name and password.

An RSA private key is generated automatically. This is the user’s private key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.

**Step 6.** Run the following command to create an organization:

An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.

**Syntax:** chef-server-ctl org-create ORG_NAME "ORG_FULL_NAME" (options)

**``` sudo chef-server-ctl org-create orguser  "chef-orguser, Inc." --association_user chefuser --filename /etc/opscode/orguser-validator.pem```**

**Step 7.** To enable Chef server web view run below commands.

**``` chef-server-ctl install chef-manage```**

**Run:**<br>

**``` sudo hostname <chef_server_publicip>```**

**``` chef-server-ctl reconfigure```**

**``` sudo chef-manage-ctl reconfigure --accept-license```** 

It takes 2 to 3 mins

After that chef server configuration is ready

**Step 8.** Run below command to install and stop the firewall. 

**``` sudo apt-get update```**

**``` sudo apt-get install -y firewalld```**

**``` sudo service firewalld stop```**

**Step 9.** You can browse chef-server from any internet browser with IP. use Username and passwords as created above.
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Workstation Configuration

In this section, we are going to learn about, how to install and configure Chef workstation.

Open new git bash terminal and send private and public keys to the workstation, these key will be used to bootstrap the workstation node as chef node.

**```scp -r ~/.ssh ubuntu@<Chefworkstation_Public_IP >:~```**

**ssh to Chef workstation.**

In git bash run :

**```ssh ubuntu@<workStationPublic_IP>```**

 Make sure the keys are copied:  

**``` ls ~/.ssh```**

**``` sudo chmod 0400 ~/.ssh/id_rsa```**

 initialize git:

**``` sudo git init```**

**``` sudo git config --global user.name "test"```**

**``` sudo git config --global user.email test@example.com```**

Download and Install ChefDk:

Run:

**``` wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb```**

**``` sudo dpkg -i chefdk_*.deb```**

 

Verify the components of the development kit:

**``` chef verify```**

Download Starter kit:

The starter kit contains chef server configuration files, It will provide connectivity with chef server. Download and moves these to the workstation.

Open a new tab on chrome browser and enter https://chef-server-public-ip

**Login: chefuser**

**Password: Password@1234**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 After a successful login, you can see chef server web console

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 

Click on "Administration tab and click" on "orguser" organization,  then select "Starter kit" from the left panel.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Click on "Download starter kit".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Click on "proceed".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Ignore the warnings and click on "Proceed".

From workstation instance run exit. and copy the starter kit  from git bash to workstation VM

run:

**``` exit```**

Now, Copy the downloaded starter kit to chef-workstation.

Run on git bash:

**```scp ~/Downloads/chef-starter.zip ubuntu@< Workstaion_Public_IP >:~```**

Now ssh to workstation

**``` ssh ubuntu@<Workstation_Public_IP>```**

Install "unzip".

**``` sudo apt-get install unzip```**

**``` sudo unzip chef-starter.zip```**

The starter kit contains chef-repo repository it has .chef, cookbooks and roles folders

where .chef folder contains knife.rb (configuration file) and chef-server user key

cookbooks folder is use to store cookbooks and it is the default path to upload the cookbook to chef server.

knife commands are supposed to be executed only from the "chef-repo" directory.

**``` cd ~/chef-repo```**

initialize the git on chef-repo. This folder contains chef configuration file (~/chef-repo/.chef/knife.rb). Run knife commands from this folder only otherwise the commands will not work.

**``` sudo git init```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Download and check the certs from the Chef Server to the CheckDK host:

**``` sudo knife ssl fetch```**

WARNING: Certificates from chef-server will be fetched and placed in your trusted_cert directory (/home/ubuntu/chef-repo/.chef/trusted_certs).
You should verify the authenticity of these certificates after downloading.

**``` sudo knife ssl check```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Bootstrap a Node

In this section, we will see how to bootstrap the workstation vm itself as chef node.

**Bootstrap the Workstation:**

Run the below command to bootstrap the workstation

 **``` sudo knife bootstrap localhost -x ubuntu -i ~/.ssh/id_rsa -N chefnode --sudo```**

 ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-server-setup/images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create a Cookbook and Apply

### Write a Cookbook

From your workstation, move to your chef-repo:

**``` cd ~/chef-repo/cookbooks```**

Moving on to create a cookbook, named lamp-stack.

**``` sudo  chef generate cookbook  apache```**

Change directory to the new cookbook.

**``` cd apache```**

Listing the files in the cookbook, you'll see the defaults.

**```ls```**

Recipes directory contains the “default.rb” recipe resources.

From within your apache directory, navigate to the recipes folder:

write a cookbook to install and enable service.

**``` sudo vim recipes/default.rb```**

Add the below code, save&quit the default.rb file (Esc:wq)

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

To apply the Apache recipe on nodes, upload the apache recipe to the chef server:

**``` sudo knife cookbook upload apache```**

Add the recipe to a node’s run-list, replacing node name with your chosen node’s name:

**``` sudo knife node run_list add chefnode "recipe[apache::default]"```**

From that node, run the chef-client:

**``` sudo chef-client```**

After a successful chef-client run, check to see if Apache is running:

**``` sudo service apache2 status```**
