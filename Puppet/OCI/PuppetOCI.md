# Puppet

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console and create VCN](#login-to-oci-console-and-create-vcn)

[Create Public and Private keypair to login into the VM](#create-public-and-private-keypair-to-login-into-the-vm)

[Create compute instances for puppet master and puppet client](#create-compute-instances-for-puppet-master-and-puppet-client)

[Login to the instance](#login-to-the-instance)

[Puppet master configuration](#puppet-master-configuration)

[Client configuration](#client-configuration)

[Creating a module](#creating-a-module)

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

`Step 1.` Sign in to your OCI account using blow credentials 
            
`Cloud Tenant` {{tenancy-name}}<br>
 `USER NAME:` {{oci-login-id}} <br>
 `PASSWORD:` {{oci-login-password}}<br>
 `Compartment Name:` {{compartment-name}} <br>

`1.1` Enter `Cloud Tenant` Name and click on `continue`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`1.2` Enter `USER NAME`, `PASSWORD` and click on `Sign In`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 2.` Reduce the browser display size as needed
           (Below example is for Chrome). 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 3.` From OCI Services menu, Choose `Networking` and click on `Virtual Cloud Networks`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 4.` Ensure correct compartment is selected select {{compartment-name}} (Bottom Left of OCI console). 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 5.` Click `Create Virtual Cloud Network.` 

`Step 6.` Fill out the dialog box:

`6.1` NAME: `PuppetVPC`<br>
`6.2` Create in Compartment: `Has the correct compartment selected.`<br>
`6.3` select radio button `Create Virtual Cloud Network Plus Related Resources.`<br>
`6.4` Click `Create Virtual Cloud Network.`<br>
`6.5` Click `Close.`<br>

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 7.` Navigate to the created virtual cloud networks.

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 8.` Go to security list and select default `security lists.`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 9.` click on `Add Ingress Rules`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 `Step 10.` Specify the below details.
 
 * SOURCE CIDR: `0.0.0.0/0` 
 * DESTINATION PORT RANGE: `443`
 * IP PROTOCOL: `TCP`

 then click on `+Additional Ingress Rule`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 `Step 11.` Specify the below details under `Ingess Rule 2`

 * SOURCE CIDR: `0.0.0.0/0` 
 * DESTINATION PORT RANGE: `8140`
 * IP PROTOCOL: `TCP`

Click on `Add Ingress Rules`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Here you can see the created ingress rules.

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create Public and Private keypair to login into the VM

In this section we will create a public/private SSH key pair. 
These keys will be used to launch a Compute instance and later 
on connect to it.

`Step 1.` Click on the `Apps` icon and click on `PuTTYgen`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 2.` Click on `Generate`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 3.` `Keep moving the mouse over the blank area(on green color) to generate the key quickly`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/missedoci1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 4.` Once the key is generated, copy the generated content in a notepad. This content should be pasted while launching the instance.

click on `Save public key`.

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 5.` Save the file in `This PC > Downloads`. Enter the file name as `PuppetKeyPair.pem` and click on `Save`.

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 6.` Go back to Putty generator and click on `Save private key`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 7.` Click on `Save Private Key`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

`Step 8.` Enter `PuppetKeyPair` as `File name`, save type as `PuTTY Private Key Files(*.ppk)` and click on `save`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Note**

In coming sections, you'll need to provide the content of key pair when you launch an instance and the corresponding private key (.ppk file) when you connect to the instance.
 
## Create a compute instance for puppet master

In this section, we will create two Compute instances with a Public 
IP address using the public SSH key generated in the previous section.

`Step 1.` Switch to OCI console.(if not already)

`Step 2.` From OCI services menu, Click `Instances` under `Compute` 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 3.` Click `Create Instance` and specify the below details.<br>

`3.1` Name: `PuppetMaster`.<br>
`3.2` Choose an operating system or image source: Choose `Canonical Ubuntu 16.04`
`3.3` Availability Domain: `AD1`.<br> 
`3.4` Instance Type: `Vitual Machine`.<br>
`3.5` Instance Shape: Choose `VM.Standard2.1.`<br>
`3.6` Virtual cloud network compartment: `Keep the default value`
`3.7` Virtual Cloud Network: `Select the Puppet VCN created in the previous section.`<br> 
`3.8` Subnet compartment: `Keep the default value`.<br> 
`3.9` Subnet: `Select the first available subnet.`<br> 
`3.10` choose radio button `Assign a public IP address`
`3.10` SSH Keys: Choose `Paste SSH keys` and paste the `PuppetKeyPair.pem` content which you copied in the previous step.<br>

click on `Create`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 4.` Once Instance is in `Running` state, note down the `public IP address.`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`similarly, launch another compute instance for Puppet client configuration.`

While launching the Puppet Client instance, Enter instance name as `PuppetClient`.

Once both `PuppetMaster` and `PuppetClient` instances are launched, you can see those in `instances` section.

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


### login to the PuppetMaster

1. Select the `PuppetMaster` instance and copy the `Public IP`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Click on `Apps Icon` and open `Putty`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Paste the `Publilc IP`, enter `port` as `22` and expand the SSH section by clicking on `+` symbol.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. select `Auth` under `SSH` section in the left panel and click on `Browse`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Go to the path where `PuppetKeyPair.ppk` file is saved, select the `PuppetKeyPair.ppk` file and click on `Open`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on `Open`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. A prompt will be opened, click on `yes`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Enter login as: `ubuntu`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Run the below command to become the root user.

   `sudo -i`

10. Puppet is domain specific language so hostname should be like puppet.example.com.

    Now change the hostname of Puppet Master server.

    Run below command.

   `hostname puppet.master.com`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Edit the hostname file by running below command.

   `vim /etc/hostname`

 12. Replace existing text with `puppet.master.com` and save the file by pressing `esc:wq`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Run this command for private IP address and copy the `inet addr`.

**ifconfig**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Note: This address will be updated in the `hosts` file along with the `PuppetClient inet addr` in coming sections.   

### login to the PuppetClient

1. Go back to oci instances page on `chrome`

2. Select the `PuppetClient` instance and copy the `Public IP`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Open one more putty session from `Apps Icon`

4. Paste the `PublicIP` and enter port as `22`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Select `PuppetKeyPair.ppk` and Enter login name as `ubuntu`

6. Run the below command to become the root user.

   `sudo -i`

7. Puppet is domain specific language so hostname should be like puppet.example.com.

    Now change the hostname of puppet client server.

    Run below command.

   `hostname puppet.client.com`

8. Edit the hostname file by running below command.

   `vim /etc/hostname`

9. Replace existing text with `puppet.client.com` and save the file by pressing `esc:wq`

10. Run this command for private IP address and copy the `inet addr`.

**ifconfig**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Note: This address will be updated in the `hosts` file along with the `PuppetMaster inet addr` in coming sections. 

## Puppet master configuration

**Puppet master setup:**

Click on `switch windows` icon and select the `PuppetMaster putty session.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run below command to pen the /etc/hosts file and configure it according to your infrastructure environment

**vim /etc/hosts**

Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

```<Puppet Master inet addr> puppet.master.com```

```<Puppet Client inet addr> puppet.client.com```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

save the file by pressing `esc:wq`

Download puppet enterprise from below command.

 **```sudo wget https://pm.puppetlabs.com/puppet-enterprise/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

 To untar the package run the following command

**```sudo tar -xf puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Change directory to puppet installer file.

**```cd puppet-enterprise-2018.1.3-ubuntu-16.04-amd64```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**```./puppet-enterprise-installer```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Puppet Enterprise offers two different methods of installation.

**[1] Text-mode Install (Recommended)**

This method will open your EDITOR (vi) with a PE config file (pe.conf) for you to edit before you proceed with installation.

The pe.conf file is a HOCON formatted file that declares parameters and values needed to install and configure PE.

We recommend that you review it carefully before proceeding.

**[2] Graphical-mode Install**

This method will install and configure a temporary web server to walk you through the various configuration options.

**NOTE:** This method requires you to be able to access port 3000 on this machine from your desktop web browser.

Enter **1** for text module installer

 In editor go to **"```console_admin_password": ""```** line type `password@1234` on quotes it is for puppet web login password.

scroll down, **Uncomment** the **```"puppet_enterprise::console_host":```**  line and enter the `puppet.master.com` in empty quotes.

**"```puppet_enterprise::console_host": "puppet.master.com"```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Press **```esc :wq```** to save the configuration file to proceed the installation enter **Y**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run the below command to Check Puppet status.

**```service puppet status```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/31.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run below command: it will generate the master certificates.

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/32.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run the below commands

**```sudo apt-get update```**

**```sudo apt-get install -y firewalld```**

**```sudo service firewalld stop```**

## Client configuration

Go back to PuppetClient putty session

Run below command to pen the /etc/hosts file and configure it according to your infrastructure environment

**vim /etc/hosts**

Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

```<Puppet Master inet addr> puppet.master.com```

```<Puppet Client inet addr> puppet.client.com```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

save the file by pressing `esc:wq`

Run the below command for puppet agent configuration in client system

**```curl -k https://puppet.master.com:8140/packages/current/install.bash | bash```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/33.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >
**In puppet Master VM:**

Let’s run the command at Puppet Master Ubuntu server to view such cert requests.

**```puppet cert list```**

Now the puppet master server must sign the cert requested from puppet client with the following command.

**```puppet cert sign puppet.client.com```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/34.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**In client VM:**

Run the following command

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Now client configuration is done.

## Creating a module

**Go to Puppet Master server:**
Run the following command to change dir to modules dir

**```cd /etc/puppetlabs/code/environments/production/modules```**

Run the below command for Creating the module.

**Modules** are self-contained bundles of code and data. You can download pre-built modules from the Puppet Forge or you can write your own modules.

Here we are writing a simple apache module which installs apache and stats the service.

**```puppet module generate foo-apache --skip-interview```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/36.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

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

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

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

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/38.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

Go to **Client VM** and run the below command to apply the apache module in client VM

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

Check the apache status run the following command.

**```service apache2 status```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

To view, the puppet enterprise web view enter https://publicip and log in with username as `admin` and password as `password@1234`.

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

After login you can see the page like below.

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/42.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >
