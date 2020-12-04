# Puppet

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console and create VCN](#login-to-oci-console-and-create-vcn)

[Create Public Or Private SSH keypair to login into the VM](#create-public-or-private-SSH-keypair-to-login-into-the-vm)

[Create a compute instance for puppet master](#create-a-compute-instance-for-puppet-master)

[login to the instance](#login-to-the-instance)

[puppet master configuration](#puppet-master-configuration)

[client confuguration](#client-confuguration)

[creating a module](#creating-a-module)

## Overview

In this lab, you'll learn how Puppet helps lay the foundation for your DevOps practices, treat infrastructure as code, and achieve better collaboration between dev, ops, InfoSec, and networking.

You'll see why thousands of companies rely on Puppet to automate the delivery and operation of their software and see it in action with a live demo.

In this lab we will show you the following in a Linux environment:

- Installation of an agent
- Managing resources (packages, files, services, etc.)
- Granular visibility through reporting
- Managing change for more efficient workflows

## Pre-Requisites
 Linux basics


## Login to OCI Console and create VCN

In this section we will login to the OCI console

**Step 1.** Sign in to your OCI account using your credentials 
            

**Step 2.** Reduce the browser display size  as needed
           (Below example is for Chrome). 

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/1.png)

**Step 3.** From OCI Services menu, click **Virtual Cloud Network** under **Networking**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/2.png)

**Step 4.** Ensure correct compart is selected (Bottom Left  
           of OCI console). 

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/3.png)

**Step 5.** Click Create Virtual Cloud Network. 

**Step 6.** Fill out the dialog box:

**6.1** **Create in Compartment:** Has the correct compartment selected.<br>
**6.2** **Name:** Enter easy to remember name (e.g. "my_vcn").<br>
**6.3** select radio button **Create Virtual Cloud Network Plus Related Resources.**<br>
**6.4** Click **Create Virtual Cloud Network.**<br>
**6.5** Click **Close.**<br>

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/4.png)

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/5.png)

**Step 7.** Navigate  to created virtual cloud networks.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/6.png)

**Step 8.** Go to security list and select default **security lists.**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/7.png)


**Step 9.** click **Edit All Rules.**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/8.png)

 **Step 10.** Click **Another Ingress Rules** and enter **source cidr** as 0.0.0.0/0 and **Destination port** range as 443 then click save changes.

 ![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/9.png)

 **Step 11.** And also open the 8140 port.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/10.png)
 
## Create Public Or Private SSH keypair to login into the VM

In this section we will create a public/private SSH key pair. 
These keys will be used to launch a Compute instance and later 
on connect to it.

**Step 1.** In the OCI Console Window, select the **Apps icon** and open **Git-Bash**. A Git-Bash terminal will appear.

**Step 2.** Enter the command **```ssh-keygen```** in git-bash window.

**HINT:** You can swap between the OCI window and any other application (git-bash etc.) by clicking the **Switch Window**  icon.

**Step 3.** Press **Enter** When asked for ‘Enter File in which to save the key’, ‘Created Directory', Press Enter when prompted for ‘Enter passphrase’, and Enter again when prompted for ‘Enter Passphrase again'.

**NOTE:** No Pass phrase is needed

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/11.png)

**Step 4.** You should now have the Public and Private keys:
             ```~/.ssh/id_rsa (Private Key)```
            ```~/.ssh/id_rsa.pub (Public Key)```

**NOTE: id_rsa.pub** will be used to create the Compute instance and **id_rsa** to connect via SSH into the Compute instance.

**HINT:** Run **```cd /C/Users/<username>/.ssh```** (No Spaces in directory path) and then **```ls```** to verify the two files exist.

**Step 5.** In git-bash Enter **```cat ~/.ssh/id_rsa.pub```**, highlight the key and **copy** (using your mouse/touch pad or Ctrl c).

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/12.png)

**Step 6.** In the OCI Console Window, click the **Apps** icon  and click **Notepad.**

**HINT:** You can swap between the OCI window and any other application (Notepad etc.) by clicking the **Switch Window**  icon.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/13.png)

**Step 7.** **Paste** the public key in Notepad (using your mouse/touch pad or Ctrl v).

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/14.png)
 
**Step 8.** **Minimize** Notepad and git-bash (if open) windows.

**We now have a Public/Private SSH key pair. Next, we will create a compute instance using the public key we just saved**
 
## Create a compute instance for puppet master

In this section, we will create two Compute instances with a Public 
IP address using the public SSH key generated in the previous section.

**Step 1.** Switch to OCI console.(if not already)

**Step 2.** From OCI servies menu, Click **Instances** under **Compute** 

**Step 3.** Click Create Instance. Fill out the dialog box:<br>

**3.1** **Name:** Enter a name (e.g. "puppet-master").<br>
**3.2** **Availability Domain:** Select the first available domain.<br> 
**3.3** **Image Operating System:** For the image, we recommend using the Latest ubuntu 16.04.<br>
**3.4** **Shape:** Select VM.Standard2.1.<br> 
**3.5** **SSH Keys:** Choose ‘Paste SSH Keys’ and paste the Public Key saved earlier.<br>
**3.6** **Virtual Cloud Network:** Select the VCN you created in the previous section.<br> 
**3.7** **Subnet:** Select the first available subnet.<br> 
**3.8** **Create Instance.**<br>

If you get any limitation error select another shape.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/15.png)

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/16.png)

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/17.png)

**Step 4.** Once Instance is in ‘Running’ state, note down the public IP address.

**Step 5.** You can also see the Fault Domain of the Virtual Machine

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/18.png)

**We now have a Compute instance with a Public IP address.**
**Next, we will SSH to the compute instance from the internet.**

**similarly, launch another compute instance for client configuration.**

## login to the instance

In this section, we will SSH into the two Compute instances using its Public IP address and private SSH key. 

**Step 1.** Bring up two git-bash terminals.

**HINT:** If the terminal was closed simply launch a new one using the **Apps icon.**

**Step 2.** In git-bash Enter command **```cd ~/.ssh/```**  Type ls and verify the **id_rsa file** exists.
             **HINT:** No Space in directory path (/C/Users/PhotonUser/.ssh).

**Step 3.** To SSH into the compute instance, Enter the command
             **```ssh –i id_rsa ubuntu@<PUBLIC_IP_OF_COMPUTE_INSTANCE>```**
             NOTE: User name is **‘ubuntu’. <PUBLIC_IP_OF_COMPUTE_INSTANCE>** should be the actual IP address e.g 129.0.1.10

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/19.png)

**Step 4.** Enter **‘Yes’** when prompted for security message. 

**Step 5.** Verify the prompt shows 
              **```ubuntu@<YOUR_VM_NAME>```**

**You now have two Compute instance in OCI with a Public IP** 
**address which is accessible over the internet.** 

## puppet master configuration

**Puppet master setup:**

Puppet is domain specific language so hostname should be like puppet.exampl.com.

now change the hostname of puppetmaster server.

Run:

 **hostname puppet.master.com**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/20.png)

similarly chang client-server hostname in client instance as 

**hostname puppet.client.com**

Edit the hostname in both master and client servers.

**vim /etc/hostname**

 replace existing with puppet.master.com in **master server** and puppet.client.com in **client server.**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/21.png)

run this command for private ipadrees in both master and client VMs and paste the IP addresses  in hosts file.

**ifconfig**

Let’s open the /etc/hosts file and configure it according to your infrastructure environment

**vim /etc/hosts**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/22.png)

10.1.0.4 puppet.master.com

10.1.0.5 puppet.client.com

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/23.png)

Similarly do in **client instance.**

**Run only in Master Server:**

we can download puppet enterprise from below command.

 **```sudo wget https://pm.puppetlabs.com/puppet-enterprise/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/24.png)

 To untar the package run the following command

**```sudo tar -xf puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/25.png)

Change directory to puppet installer file.

  **```cd puppet-enterprise-2018.1.3-ubuntu-16.04-amd64```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/26.png)

**```./puppet-enterprise-installer```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/27.png)

Puppet Enterprise offers two different methods of installation.


**[1] Text-mode Install (Recommended)**

This method will open your EDITOR (vi) with a PE config file (pe.conf) for you to edit before you proceed with installation.

The pe.conf file is a HOCON formatted file that declares parameters and values needed to install and configure PE.

We recommend that you review it carefully before proceeding.

**[2] Graphical-mode Install**

This method will install and configure a temporary web server to walk you through the various configuration options.

**NOTE:** This method requires you to be able to access port 3000 on this machine from your desktop web browser.


Enter **1** for text module installer

 In editor go to **"```console_admin_password": ""```** line type password on quetes it is for puppet web login password.

**Uncomment** the "puppet_enterprise::console_host":  line and enter the puppet.master.com in empty quets.

**"```puppet_enterprise::console_host": "puppet.master.com"```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/28.png)

Press **```esc :wq```** to save the configuration file to proceed the installation enter **Y**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/29.png)

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/30.png)

Run the below command to Check Puppet status.

**```service puppet status```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/31.png)

Run below command: it will generate the master certificates.

**```Puppet agent -t```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/32.png)

Run below commands to open firewall ports

**```sudo apt-get update```**

**```sudo apt-get install -y firewalld```**

**```sudo service firewalld stop```**

## client confuguration

Run the below command for puppet agent configuration in client system

**```curl -k https://puppet.master.com:8140/packages/current/install.bash | bash```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/33.png)

**In puppet Master VM:**

Let’s run the command at Puppet Master Ubuntu server to view such cert requests.

**```puppet cert list```**

Now the puppet master server must sign the cert requested from puppet client with the following command.

**```puppet cert sign puppet.client.com```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/34.png)

**In client VM:**

Run the following command

**```Puppet agent -t```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/35.png)

Now client configuration is done.

## creating a module

**Go to Puppet Master server:**
Run the following command to change dir to modules dir

**```cd /etc/puppetlabs/code/environments/production/modules```**

Run the below command for Creating the module.

**Modules** are self-contained bundles of code and data. You can download pre-built modules from the Puppet Forge or you can write your own modules.

Here we are writing a simple apache module which installs apache and stats the  service.

**```puppet module generate foo-apache --skip-interview```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/36.png)

**```cd apache/manifests```**

**```vim  init.pp```**

Press Shif +g  the curser will go to the bottom of vim editor 

Press i to change vim to insert mode. Enter the below lines in apache class.

```
package { 'apache2':
  
  ensure => installed,
}

 service { 'apache2':
  ensure => running,
}
```

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/37.png)

Run below command to parse the Module

**```puppet parser validate init.pp```**

 **```puppet apply init.pp --noop```**

 To apply module on client node we need to modify the site.pp  

Change directory to manifests

**```cd /etc/puppetlabs/code/environments/production/manifests/```**

**```vim site.pp```**

Enter below lines  

```
node 'puppet.client.com' {

       class { 'apache': }

}
```

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/38.png) 

Go to **Client VM** and run the below command to apply the apache module in client VM

**```Puppet agent -t```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/39.png) 

Check the apache status run the following command.

**```service apache2 status```**

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/40.png) 

To view, the puppet enterprise web view enter https://publicip and log in with username as admin and password as you given while puppet master installation.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/41.png) 

After login you can see the page like below.

![](https://github.com/Anilkumarsunkesula/VSTS-test//raw/master/puppet/42.png)
