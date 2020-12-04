# CHEF-AUTOMATE

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console and create VCN](#login-to-oci-console-and-create-vcn)

[Create Public and Private SSH keypair to login into the VM](#create-public-and-private-ssh-keypair-to-login-into-the-vm)

[Create compute instances for chef server, chef automate and chef workstation](#create-compute-instances-for-chef-server-chef-automate-and-chef-workstation)

[login to the instance Chef server](#login-to-the-instance-chef-server)

[Installing and configuring chef server](#installing-and-configuring-chef-server)

[Install and cofigure Chef Automate](#install-and-cofigure-chef-automate)

[Configure chef worstation](#configure-chef-worstation)

[Bootstrap a node, Scan and fix compliance issues](#bootstrap-a-node-scan-and-fix-compliance-issues)

## Overview

### Chef Automate
Chef Automate provides a full suite of enterprise capabilities for workflow, node visibility and compliance. Chef Automate integrates with the open-source products Chef, InSpec and Habitat. Chef Automate comes with comprehensive 24×7 support services for the entire platform, including open source components.
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Compliance:
Chef Automate 1.5.46 or later provides an easy way to view how successful the nodes in your infrastructure are at meeting the compliance requirements specified by your organization. Several built-in profiles are included in Chef Automate to scan for security risks, outdated software, and more. These profiles cover a variety of security frameworks, such as Center for Internet Security (CIS) benchmarks. If you have additional compliance requirements, you can also write your own compliance profiles in InSpec and upload them to Chef Automate. For more information how to view the compliance status across your cluster, see Compliance Overview.

If you are using an older version of Chef Automate, or your workflow requires you to use our standalone Chef Compliance server, you can find general information on Chef Compliance here

In this training lab, you'll learn how to configure Chef server, Chef automate server and workstation on ubuntu 16.04 and finding, fixing the compliances in ubuntu.

## Pre-Requisites
- Linux basics

## Login to OCI Console and create VCN

### Creating VCN:

In this section, we will log in to the OCI console and adjust your screen size (if needed).

**Step 1.** Get OCI Sign detailes from left top of content window as shown below.<br>
     **NOTE:** To copy the access details click on requred value and past it in you work space window.
     
**Tenancy Name:** {{tenancy-name}}<br>
 **OCI login_ID:** {{oci-login-id}} <br>
 **OCI login_Password:** {{oci-login-password}}<br>
 **Compartment Name:** {{compartment-name}} <br>

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 2.** Reduce the browser display size  as needed (Below example is for Chrome). 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 3.** From OCI Services menu, click "Virtual Cloud Network", under "Networking".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 4.** Ensure the correct compartment is selected (Bottom Left of OCI console). 

Choose Compartment as  {{compartment-name}}

**Note:** Keep the dynamically generated compartment ID, for use through out the lab and make sure you have selected the same in this step. 

**Step 5.** From OCI menu (click Left top corner) select **Virtual Cloud Networks** and then click "Create Virtual Cloud Network"

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 6.** Fill out the dialog box

**6.1** Create in Compartment: Has the correct compartment selected.<br>
**6.2** Name: Enter easy to remember name (e.g. "my_vcn").<br>
**6.3** Select radio button Create Virtual Cloud Network Plus Related Resources<br>
**6.4** Click Create Virtual Cloud Network.<br>
**6.5** Click Close.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 7.** Navigate to created virtual cloud network

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 8.** Select **"security lists"** on the navigation panel and click on "default security list".  

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 9.** Click "Edit All Rules".

 ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 10.** Click on "Ingress Rules" then click **"+Another Ingress rule"** and enter source cidr as 0.0.0.0/0 and Destination port range as 443 then click save changes.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create Public and Private SSH keypair to login into the VM

 In this section, we will create a public/private SSH key pair. 

These keys will be used to launch a Compute instance and connect to it.

**Step 1.** In the OCI Console Window, select the "Apps icon" and open "Git-Bash". A Git-Bash terminal will appear.

**Step 2.** Enter the command **```ssh-keygen ```** in the git-bash window.

**HINT:** You can swap between the OCI window and any other application (git-bash etc.) by clicking the "Switch Window"  icon.

**Step 3.** Skip entering any values in next steps by hitting on "Enter" Key.

**NOTE:** No Passphrase is needed.       

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 4.** You should now have the Public and Private keys:

   **```~/.ssh/id_rsa``` (Private Key)**<br>
   **```~/.ssh/id_rsa.pub``` (Public Key)**

**NOTE:** "id_rsa.pub" will be used to create the Compute instance and "id_rsa" to connect via SSH into the Compute instance.
 
**HINT:** Run **```cd ~/.ssh```** and then **```ls```** to verify the two files exist.

**Step 5.** In git-bash Enter **```cat ~/.ssh/id_rsa.pub```**, highlight the key and copy.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 6.** In the OCI Console Window, click the "Apps" icon  and click "Notepad". 
 
**HINT:** You can swap between the OCI window and any other application (Notepad etc.) by clicking the Switch Window  icon.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Step 7.** Paste the public key in Notepad.
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
**Step 8.** Minimize Notepad and git-bash (if open) windows.

We now have a Public/Private SSH key pair. Next, we will create a compute instance using the public key we just saved
 

## Create compute instances for chef server, chef automate and chef workstation

In this section, you'll be creating three Compute instances (Chef server, chef automate and chef workstation VMs)with a Public 
IP address, using the public SSH key generated in the previous section.

Creating Chef server compute Instance:

Step 1. Switch to OCI console. (if not already)

Step 2. From OCI services menu, Click Instances under Compute 

Step 3. Click Create Instance. Fill out the dialog box:<br>

3.1 Name: Enter a name (e.g. "chef-server").<br>
3.2 Availability Domain: Select the first available domain. (Ad1)<br>
3.3 Image Operating System: For the image, Ubuntu 16.04 latest image available.<br>
3.4 Shape: Select VM.Standard2.1. select another shape if instance creation fails. <br>
3.5 SSH Keys: Choose ‘Paste SSH Keys’ and paste the Public Key saved earlier.<br>
3.6 Virtual Cloud Network: Select the VCN you created in the previous section. <br>
3.7 Subnet: Select the first available subnet. <br>
3.8 Click on "Create Instance".

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
Similarly, create Chef automate and Workstation Instances.

Note: If you come across any limitation error, select another shape for the VM.

Step 4. Once Instances are in ‘Running’ state, note down the public IP addresses.

Step 5. You can also see the Fault Domain of the Virtual Machine.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

We now have three Compute instances with  Public IP addresses.

Next, we will SSH to the compute instances.

## login to the instance Chef server

Step 1. Bring up "git-bash" terminal.

HINT: If the terminal was closed simply launch a new one using the "Apps" icon .

Step 2. SSH into the compute instance using the command,

**``` ssh ubuntu@<PUBLIC_IP_OF_COMPUTE_INSTANCE>```**

NOTE: User name is ‘ubuntu’. <PUBLIC_IP_OF_COMPUTE_INSTANCE> should be the actual IP address e.g 129.0.1.10 

NOTE: Enter ‘Yes’ when prompted for security message. 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3. Verify the prompt shows 

**ubuntu@<YOUR_VM_NAME>** (below example show Compute instance called ‘mean-vm’)

## Installing and configuring chef server

In this section, you'll be installing and configuring the Chef server.

Go to git-bash, where you're already logged in to the Chef server. 

Installation Script:

The below script will download and install the chef server and it creates chef user(chefadmin) and organization (orguser). 

In chef-server **Run:**

**``` wget https://raw.githubusercontent.com/sysgain/tl-scripts/master/chef-server.sh```**
 
**``` bash chef-server.sh```**
 
The process would take 10 to 15 minutes. Meanwhile, go to the next section and Install Chef automate.

## Install and cofigure Chef Automate

In this section, we are going to install Chef Automate server and create a user for Chef Automate web console.

1. Copying keys to Chef Automate server:

    1.1 Open a new "Git-bash" from the "Apps" icon. 

    1.2 To get the key from Chef-server with SCP command, you'll need SSH keys into Automate server. 

    1.3 In this lab, we are using the same private and public keys (id_rsa and id_rsa.pub)for all the three servers. Push these keys from git bash to Automate server with scp command.

    1.4 Run the below command to copy the "~/.ssh" folder to Chef Automate Home directory.

    **```scp -r ~/.ssh ubuntu@<ChefAutomate_public_IP>:~```**<br>
    
    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    1.5 Now login to Chef Automate server 

    **```ssh ubuntu@<Public_IP>```**

    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    1.6 Check for the copied keys:<br>  **```ls ~/.ssh```**

    1.7 we will copy the Chef user-key after Chef-server setup script is succeeded.

2. Download and Install Chef Automate:<br>

    Download Chef Automate deb package,

    **``` sudo wget https://packages.chef.io/files/stable/automate/1.8.38/ubuntu/16.04/automate_1.8.38-1_amd64.deb```**
 
    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
3. Installing deb package:<br>
 
    **``` sudo dpkg -i automate_1.8.38-1_amd64.deb```**

    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
    
    To set up the Chef Automate server we require Chef server user key and Chef Automate license. Run below command to get temporary Automate license.
 
    **``` sudo wget https://aztdrepo.blob.core.windows.net/chefautomate-testdrive/automate.license -O /tmp/automate.license```**
 
   Next, wait until Chef server script succeeded.
 
4. Copying user key from Chef-server:
 
    4.1 The SSH keys, which we copied earlier may have excess permissions which may be Vulnerable. Change the permission levels by,
 
    **``` sudo chmod 0400 ~/.ssh/id_rsa```**
 
    4.2 Run below command it copies the Chef-server user key to /tmp directory. Enter "yes" to continue connecting with Chef server.
 
    **``` scp ubuntu@<chef-server IP>:/etc/opscode/chefadmin.pem /tmp ```**
 
5. Chef Automate Setup:
 
    Run below command to set up the Automate server, in this command, we are passing the Automate license, Chef-server user key file paths and chef server Private key(take it from OCI instance details page). 
 
    **``` sudo automate-ctl setup --license /tmp/automate.license --key /tmp/chefadmin.pem --server-url https://<Chef-server-PrivateIP>/organizations/orguser --fqdn $(hostname) --enterprise default --configure --no-build-node```**
 
    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
    **``` sudo automate-ctl reconfigure```**
 
6. Creating Chef Automate user:
 
    **``` sudo automate-ctl create-user default chefuser --password Password@1234 --roles "admin"```**
 
    Allow 443 on Firewall:
 
    To access the Chef Automate web view from browsers we need to open firewalld https port.
    ```sh
    sudo apt-get update
    sudo apt-get install -y firewalld
    sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
    sudo firewall-cmd --reload
    ```
    **NOTE:** Run below commands on **Chef server**
 
    Go to chef server:
 
    **``` sudo chmod 777 /etc/opscode/chef-server.rb```**
 
    Pass Chef Automate IP in below command and run it enables the compliance data collection.
 
    **``` sudo echo "data_collector['root_url'] = 'https://<Automate public IP>/data-collector/v0/'" >> /etc/opscode/chef-server.rb```**

    **```sudo chef-server-ctl reconfigure```**
 
    Browse Chef Automate on your favorite browser 

    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
    ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
 
## Configure chef worstation

In this section, you'll learn how to install Chefdk and workstation configuration steps.

1. Open a new "git-bash" terminal 

2. We need to send private and public keys to the Workstation. Follow steps mentioned in the previous section.

   **```scp -r ~/.ssh ubuntu@<Chefworkstation_public_IP>:~```**<br>

   ssh to Chef workstation 

   In git-bash run 

   **```ssh ubuntu@<workStationPublic_IP>```**

3. Check keys are copied or not:<br>  

   **```ls ~/.ssh```**
   
   **``` sudo chmod 0400 ~/.ssh/id_rsa```**
   
   Download and Install ChefDk
   
   initialize git

   
   ```sh
   sudo git init
   sudo git config --global user.name "test"
   sudo git config --global user.email test@example.com
   wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
   sudo dpkg -i chefdk_*.deb
   ```
   verify the components of the development kit

   **```Chef verify  ```**

4. Download Starter kit

   Open a new tab on chrome browser and enter **https://< Chef-server-public-ip>**

   **Login: chefadmin**<br>
   **Password: Password@1234**

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   After login, you can see Chef server web console

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Click on Administration tab and click on orguser organization,  then select Starter kit from the left panel.

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Click on Download starter kit

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/31.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Click proceed

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/32.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Click on proceed if any warnings you got

   From workstation instance run exit. and copy the starter kit from git bash to workstation VM

   **run:**<br> **``` exit```**

   Now we need to copy the downloaded starter kit to Chef-workstation.

   **Run in git bash**

   **```scp ~/Downloads/chef-starter.zip ubuntu@<workstationIP>:~```**

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/33.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


   ssh to workstation

   **```ssh ubuntu@<workstation PublicIP>```**

   Install unzip

   **```sudo apt-get install unzip```**
   
   **```sudo unzip chef-starter.zip```**

   The starter kit contains Chef-repo repository. it has ".Chef", cookbooks and roles folders

   where .chef folder contains knife.rb (configuration file) and Chef-server user key

   cookbook folder is to store cookbooks and it is the default path to unload the cookbook to Chef server.

   NOTE: You have to run every knife command from chef-repo folder

   **```cd ~/chef-repo```**

   Initialize the git on Chef-repo

   **```sudo git init```**

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/34.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

5. Download and check the certs from the Chef Server to the CheckDK host:

   **```sudo knife ssl fetch```**

   WARNING: Certificates from Chef-server will be fetched and placed in your trusted_cert directory (/home/ubuntu/Chef-repo/.Chef/trusted_certs).

   You should verify the authenticity of these certificates after downloading.

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   **```sudo knife ssl check```**

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/36.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Bootstrap a node, Scan and fix compliance issues

In this section, we will see how to bootstrap the workstation vm itself as chef node and scan the compliance and fix the issues by applying cookbooks on the workstation

Bootstrap the Workstation:

1. Run the below command to bootstrap the workstation

**``` sudo knife bootstrap localhost -x ubuntu -i ~/.ssh/id_rsa -N chefnode --sudo```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Now download the cookbooks

**``` sudo git clone https://github.com/sysgain/OCI-chef-tl-cookbooks.git```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/38.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Move or copy the cookbooks to cookbook folder.

**``` sudo mv  OCI-chef-tl-cookbooks/* cookbooks/```**

Upload Cookbooks to Chef Server:

**Run**

**``` sudo knife cookbook upload audit-linux compat_resource ohai sysctl os-hardening```**

4. Check the Automate server there you can see a node is added

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

5. Now add audit-linux recipe to chefnode run list

**``` sudo knife node run_list add chefnode "recipe[audit-linux]"```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Now run:**

**``` sudo chef-client```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

6. Go to Chef automate and click compliance tab, here we see the chef node compliances.

  ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/42.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. Click on 1Nodes then click node name to view the list of compliances.

   ![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/43.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

To fix the issues we need to apply the os-hardening cookbook.

8. Add the os-hardening recipe to chefnode runlist

**``` sudo knife node run_list add chefnode "recipe[os-hardening]"```**

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/44.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Now run :

**``` sudo chef-client```**

It will fix compliance issues.

9. Now refresh the Chef automate you can see the node is passed in compliance tab.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/chef-automate/images/45.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
