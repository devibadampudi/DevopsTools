  # Puppet

  # Table of Contents

  [Overview](#overview)

  [Pre-Requisites](#pre-requisites)

  [Login to Azure Portal and create Virtual Machines](#login-to-azure-portal-and-create-virtual-machines)

  [Login to the VMs](#login-to-the-vms)

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

  ## Login to Azure Portal and create Virtual Machines

  ### Login to Azure Portal

  In this section we will login to the Azure Portal and Deploy Virtual Machines

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}<br>
 **Resource group Name:** {{resource-group-name}} <br>
 **location:** {{azure-rg-location}}
 
In the lab console window, use the web browser and go to https://portal.azure.com

Enter the username provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Enter the password Provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The dashboard of the Azure portal will Appear after a successful login.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Launch Virtual Machines for Puppet Master and Puppet Client

Launching a VM:

`Step 1:` On Azure portal (https://portal.azure.com), click on **"Create a resource"** from the navigation pane.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 2:` Search for `Ubuntu Server 16.04`, select `Ubuntu 16.04 LTS` from the dropdown.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`step 3:` Click on `Create`  

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 4:` Specify the below details.

 * Subscription: `Keep the default value`.
 * Resource group: Choose `{{resource-group-name}}`.<br>
 * Virtual Machine Name: `PuppetMaster`<br>
 * Region: Choose `{{azure-rg-location}}`
 * Availability options: `No infrastructure redundancy required`
 * Authentication type: `Password` <br>
 * Username: `puppetuser`<br>
 * Password: `Password@1234`<br>
 * size: `Standard D2 V3`<br>
 * Public inbound ports: Check the radio button `Allow selected ports` and allow ports 22 from the dropdown.

 click on `Next: Disks >`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 5:` On the next steps `Disks and Networking`, Leave all fields to defaults and proceed to the `Management` tab.

`Step 6:` Set the `Boot Diagnostics` to `Off` and proceed over to the final step `Review and Create`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 
 
`Step 7:` click on `create` after you see that the validation succeeds.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 8:` You will get a notification once the deployment is succeeded. Click on `Go to resource`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 9:` Here you can see the Puppet Master Virtual machine.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 10` Click on `Resource group`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 11` Here you can see the resources that are created along with the PuppetMaster VM.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 12` Click on `PuppetMaster-nsg` to add the inbound rules.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 13` Navigate to `Inbound Security rules` section in the left pane.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 14` Click on `+Add`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 15` Specify the below details.

  * Destination port ranges: `443`
  * Priority: `310`
  * Name: `Port_443`

  Keep the default vales for others and Click on `Add`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 16` Now `443 port` is added.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 17` Add one more rule for port `8140`

  * Destination port ranges: `8140`
  * Priority: `320`
  * Name: `Port_8140`

  Keep the default vales for others and Click on `Add`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 18` Both `443` and `8140` ports are added now for Puppet Master

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 19` Similarly launch one more VM for `PuppetClient`. Click on `Options` at the top left corner of the    Portal and click on `Create a resource`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 20` While launching the Client VM, Give Virtual machine name as `PuppetClient`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 21` Once the deployment is completed, you can see the `PuppetClient` VM.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)          

  ## Login to the VMs

  In this section, we will login to virtual machines using the Public IP address.

  ### login to Puppet Master VM

  `Step 1` Click on `Options` at the top left corner of the Portal and click `Resource groups`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 2` Select `{{resource-group-name}}`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)    

  `Step 3` Select `PuppetMaster` virtual Machine

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  `Step 4` Copy the `Public IP address`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 5` Click on `Apps Icon` and open `Putty`

  <img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

  `Step 6` Paste the Public IP address and click on `open`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 7` Click on `Yes`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  `Step 8` Enter **Username:** puppetuser and **Password:** Password@1234

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 9` Run the below command to become the root user

  `sudo -i`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 10` Run the below command to change the hostname of puppetmaster server.

  `hostname puppet.master.com`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 11` Edit the hostname file by running below command.

   `vim /etc/hostname` 

  `Step 12` Replace existing text with `puppet.master.com` and save the file by pressing `esc:wq`

   <img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

  `Step 10` Run this command for private IP address and copy the `inet addr`.

  `ifconfig`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure31.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  Note: This address will be updated in the `hosts` file along with the `PuppetClient inet addr` in coming sections.

  ### login to the Puppet Client VM

  `Step 1` Select `{{resource-group-name}}` Resource group.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  `Step 2` Select `PuppetClient` VM.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure32.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

  `Step 3` Copy the `Public IP Address`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure33.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 4` Open one more `putty terminal`.

  `Step 5` Paste the `Public IP Address` and click on `Open` 

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure34.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 6` Enter **Username:** puppetuser and **Password:** Password@1234

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  `Step 7` Run the below command to become the root user

  `sudo -i`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure36.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 8` Run the below command to change the hostname of puppet client server.

  `hostname puppet.client.com`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 9` Edit the hostname file by running below command.

   `vim /etc/hostname` 

  `Step 10` Replace existing text with `puppet.client.com` and save the file by pressing `esc:wq`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure38.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  `Step 11` Run this command for private IP address and copy the `inet addr`.

  `ifconfig`

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  Note: This address will be updated in the `hosts` file along with the `PuppetClient inet addr` in coming sections.


  ## Puppet master configuration

  **Puppet master setup:**

  Click on `switch windows` icon and select the `PuppetMaster putty session.`

  <img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

  Let’s open the /etc/hosts file and configure it according to your infrastructure environment

  `vim /etc/hosts`

  Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

  ```<Puppet Master inet addr> puppet.master.com```

  ```<Puppet Client inet addr> puppet.client.com```

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  **Run only in Master Server:**

  we can download puppet enterprise from below command.

  **```sudo wget https://pm.puppetlabs.com/puppet-enterprise/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/13.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  To untar the package run the following command

  **```sudo tar -xf puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/14.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Change directory to puppet installer file.

  **```cd puppet-enterprise-2018.1.3-ubuntu-16.04-amd64```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/15.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Run the below command to install the puppet enterprise.

  **```./puppet-enterprise-installer```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/16.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

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

  **Uncomment** the **```"puppet_enterprise::console_host":```**  line and enter the puppet.master.com in empty quotes.

  **"```puppet_enterprise::console_host": "puppet.master.com"```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/17.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Press **```esc :wq```** to save the configuration file to proceed the installation enter **Y**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/18.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Run the below command to Check Puppet status.

  **```service puppet status```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/19.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Run below command: it will generate the master certificates.

  **```puppet agent -t```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/20.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  ## Client configuration

  Click on `switch windows` icon and select the `PuppetMaster putty session.`

  <img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

  Let’s open the /etc/hosts file and configure it according to your infrastructure environment

  `vim /etc/hosts`

  Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

  ```<Puppet Master inet addr> puppet.master.com```

  ```<Puppet Client inet addr> puppet.client.com```

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  Run the below command for puppet agent configuration in client system

  **```curl -k https://puppet.master.com:8140/packages/current/install.bash | bash```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/21.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  **In puppet Master VM:**

  Let’s run the command at Puppet Master Ubuntu server to view such cert requests.

  **```puppet cert list```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/22.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Now the puppet master server must sign the cert requested from puppet client with the following command.

  **```puppet cert sign puppet.client.com```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/23.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  **In client VM:**

  Run the following command

  **```puppet agent -t```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/24.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  Now client configuration is done.

  ## Creating a module

  **Go to Puppet Master server:**
  Run the following command to change dir to modules dir

  **```cd /etc/puppetlabs/code/environments/production/modules```**

  Run the below command for Creating the module.

  **Modules** are self-contained bundles of code and data. You can download pre-built modules from the Puppet Forge, or you can write your own modules.

  Here we are writing a simple apache module which installs apache and stats the service.

  **```puppet module generate foo-apache --skip-interview```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/25.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  **```cd apache/manifests```**

  **```vim  init.pp```**

  Press Shif +g the curser will go to the bottom of vim editor 

  Press i to change vim to insert mode. Enter the below lines in apache class.

  ```
  package { 'apache2':
    
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
  }
  ```

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/26.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

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

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/27.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  Go to **Client VM** and run the below command to apply the apache module in client VM

  **```puppet agent -t```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/28.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  Check the apache status run the following command.

  **```service apache2 status```**

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/29.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  To view, the puppet enterprise web view enter https://publicip and log in with username as `admin` and password as `password@1234`.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  After login you can see the page like below.

  ![alt text](https://qloudableassets.blob.core.windows.net/devops/Azure/Puppet/puppetAzure42.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 
