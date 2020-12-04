# Jenkins Basics
## Table of contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console](#login-to-oci-console)

[Installing Jenkins](#installing-jenkins)

[Jenkins Configuration](#jenkins-configuration)

[Freestyle Jobs](#freestyle-jobs)

[Freestyle with Parameterized Jobs](#freestyle-with-parameterized-jobs)

[Upstream and Downstream Jobs](#upstream-and-downstream-jobs)

## Overview

The aim of this lab is to understand the basics of Jenkins like Installation, Configuring, Creating Building Freestyle Jobs, Freestyle with Parameterized Jobs and Upstream Downstream Jobs.

Jenkins is a self-contained, open source automation server which can be used to automate all sorts of tasks related to building, testing, and delivering or deploying software.  

## Pre-Requisites

* None required.

## Login to OCI Console

In this section we will login to the OCI console

1. Sign in to your OCI account using your credentials 

* **Cloud Tenant:** {{Cloud_Tenant}}
* **User Name:** {{User_Name}}
* **Password:** {{Password}}

2. Enter the Cloud Tenanat name

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter user name and password

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Reduce the browser display size  as needed
           (Below example is for Chrome). 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. From OCI Services menu, choose `Compute` --> Instances.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


* **Compartment Name:** {{compartment_name}}


6. Choose correct `compartment` name as mentioned above.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Click on Jenkins instance and copy the Public IP {{public_ip_address}}

6. Select `Apps Icon` and click on `PUTTY`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Paste the public IP address `{{public_ip_address}}`and click on `open`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/putty.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Use below credentials to login `Jenkins Virtual Machine`. 

    * **Instance username:** {{vm-user-name}}
    * **Instance password:** {{vm-user-password}}

## Installing Jenkins

Install Jenkins on your ubuntu machine, follow these steps:

1. Update the packages  
	
```
sudo apt-get update
```

2. Install java 8 Open JDK package.  

```
sudo apt-get install openjdk-8-jdk
```

3. Add the Jenkins Debian repository to the system  

```
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
```

4. When the key is added, the system will return `OK`. Next, we'll append the Debian package repository address to the server's `sources.list`:  

```
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
```

5. Update the packages one more time  

```
sudo apt-get update
```

6. Finally install the latest version of Jenkins with the following command.

```
sudo apt-get install jenkins -y
```

7. After installation, Jenkins service starts automatically. Verify using following command.

```
sudo service jenkins status
```
  Output looks as shown below. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/status-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. To set up your latest Jenkins installation, open jenkins on browser using service host name or IP address followed by port 8080. `http://{{public_ip_address}}:8080/`  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/unlock-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Go back to VM and execute the following command  

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Jenkins installer creates an initial 32character alphanumeric password copy and paste it into the browser `Administrator password`, then click `Continue`.  

10. The setup wizard provides options `Install suggested plugins` or `Select plugins to install`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/customize-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


11. Click `Install suggested plugins` to start plugins installation.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/getting-started.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


12. Once the plugins are installed, you will be prompted to set up the first admin user. Fill out all required information and click `Save and Continue`.

    * **Admin Username:** {{Jenkins_UI_username}}
    * **Admin Password:** {{Jenkins_UI_password}}
    * **Full name :**     {{user-name}}
    * **E-mail address:** jenkins@jenkins.com

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/create-admin-user.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


13. Next, set the URL for your Jenkins instance. The URL will be generated automatically, confirm the URL by clicking `Save and Finish`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/instance-configuration.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


14. Once configuration is done, you see `Jenkins is ready!`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/jenkins-ready.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


15. Click `Start using Jenkins` it will be redirected to the Jenkins dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/dashboard.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Jenkins Configuration

#### Manage Plugins

Plugins are the primary means of enhancing the functionality of a Jenkins environment to suit organization- or user-specific needs. There are over a thousand different plugins which can be installed on a Jenkins master and to integrate various build tools, cloud providers, analysis tools, and much more.

The plugins are packaged as self-contained `.hpi` files, which have all the necessary code, images, and other resources which the plugin needs to operate successfully.

Plugins can be automatically downloaded, with their dependencies, from the Update Center. The Update Center is a service operated by the Jenkins project which provides an inventory of open source plugins which have been developed and maintained by various members of the Jenkins community.

**Installing Plugins**

* They are two methods for installing plugins on Jenkins master.

	* Manage Plugins on Classic UI 
	* Jenkins CLI

In this lab we are using **Manage Plugins on Classic UI** to install plugins.

1. Click `Manage Jenkins` on Jenkins dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/manage_jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


2. Select `Manage Plugins` section.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/manage-plugins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. Click on `Available` tab. Available plugins list is displayed, find your plugin using filter `e.g. green balls`.

4. Select the check box on your favorite plugin and click `Install without restart`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/green_balls.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. After plugin installation is done, you will get the success message. We will use this plugin in coming sections.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/green_balls_success.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Advanced installation**

Here you can upload your own plugins to the Jenkins master in `.hpi` format. Create your plugins you need knowledge on Java programming, because Jenkins is written in java.

1. Click `Manage Jenkins` on Jenkins dashboard. 

2. Select `Manage Plugins` view

3. Click on `Advanced` tab

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/advance_tab.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Scroll down to `upload Plugins` section.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/upload_plugin_section.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. For this lab we already created custom plugin, copy the link and paste it in browser `https://updates.jenkins-ci.org/download/plugins/sounds/0.5/sounds.hpi`

6. Click on `Choose File` button and select the `sounds.hpi` plugin (which you downloaded in the above step). Click `Upload` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/upload_plugin.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


7. After plugin installation is done, you will get the success message. 

8. Click on the check box `Restart Jenkins when installation is comleted and no jobs are running` to restart the Jenkins server manually to affect the plugin changes.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/upload_plugin_sucess.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Once the Jenkins server is restarted, login to the jenkins server by using below credentials.

    * **Jenkins url:** http://{{public_ip_address}}:8080
    * **Jenkins username:** {{Jenkins_UI_username}}
    * **Jenkins password:** {{Jenkins_UI_password}}

10. Once you logged to the Jenkins server you can able to see the `Sounds` on left side navigation pane of Jenkins dashboard. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/sounds_icon.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


**Updating a Plugins**

If any plugin is outdated or a version upgrade is available, we can see the list of plugins in update tab.

1. Click `Manage Jenkins` on Jenkins dashboard.  

2. Select `Manage Plugins` view 

3. Select the `Check Now` button on updates tab. it will check if updates available on update center.

4. You are in update tab, you can see the list of plugins need to update.

5. By updating the plugin clicking the checkbox of the desired plugins and select `Download now and install after restart` button. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/updateds.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once the Jenkins server is restarted, login to the jenkins server by using below credentials.

    * **Jenkins url:** http://{{public_ip_address}}:8080
    * **Jenkins username:** {{Jenkins_UI_username}}
    * **Jenkins password:** {{Jenkins_UI_password}}

**Uninstalling a Plugin**

Jenkins will automatically determine which plugin is safe to uninstall those which are not dependent on other plugins.

1. Click `Manage Jenkins` on Jenkins dashboard.

2. Select `Manage Plugins` view

3. Click on `Installed` tab

4. You will see the list of plugins with uninstall option, those are not dependent on other plugins.
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/uninstall.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >
 
5. In the above section we have installed, updated and uninstalled plugins.

#### Change Jenkins Home Directory

1. Click on `Manage Jenkins` on Jenkins dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/manage_jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


2. Select `System Information` tab.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/system_information.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. Scroll down to `Environment Variables` section, you will see the `JENKINS_HOME`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/old-env-variable.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


4. For changing the Jenkins home, Navigate to `Putty`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/navigate-putty.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Navigate to root user using following commands.

```
sudo -i
```
6. Before changing anything on Jenkins master, stop the Jenkins server

```  
sudo service jenkins stop
```
7. Create a new directory where Jenkins home has to move. In this lab we are creating new directory in ``/home`` path.

```
mkdir /home/new_home

```

```
ls
```
8. We need to change the ownership of created directory by using the `chown` command to change the user and group ownership of created directory.

```
sudo chown jenkins:jenkins /home/new_home/
```
9. Copy the content from old jenkins home directory `/var/lib/jenkins` to new jenkins home directory `/home/new_home/` using following command.

```
sudo cp -prv /var/lib/jenkins /home/new_home/
```
10. Next change the Jenkins user home by using following command.

``` 
sudo usermod -d /home/new_home/ jenkins
```
11. Update the new Jenkins home directory path in `/etc/default/jenkins`.

``` 
sudo vi /etc/default/jenkins
```
12. Scroll down to Jenkins home location update new home directory path.

```
# Jenkins home location 
JENKINS_HOME=/home/new_home
```
13. Save the file in `vi` editor by pressing `ESC` and `:wq`.

14. After saving the file, start the Jenkins service by using following command.

```
sudo service jenkins start 
```
15. Then we need to update the admin password that can be found in new Jenkins home directory. 

```
cat /home/new_home/secrets/initalAdmkinPassword  
```
16. Open Jenkins on browser using service host name or IP address followed by port 8080. `http://{{public_ip_address}}:8080/` and then Copy and paste the Admin Password in `Administrator Password` field. Click `continue` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/unlock-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


17. Next you will be prompted to set up the first admin user. Fill out all required information and click `Save and Continue`.

18. Next set the URL for your Jenkins instance. The URL will be generated automatically, confirm the URL by clicking `Save and Finish` button.

19. Once all configuration is done, you can see the `Jenkins is ready!`. click `Start using Jenkins` it will be redirected to the Jenkins dashboard.

20. Click on `Manage Jenkins` on Jenkins dashboard.

21. Select `System Information`.

22. Scroll down to `Environment Variables` section, you see new `JENKINS_HOME` path.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/new_env-variables.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Freestyle Jobs

Jenkins can be used to perform builds on servers that works like regular builds, run test and repetitive tasks.

Steps to create freestyle project in Jenkins.

1. Select `New Item` on dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/new-item.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


2. Enter the name of your project in the `Enter an item name` field, e.g: `Project_1` and Select `Freestyle Project`, and click `OK` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/enter-name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. Enter `Description` (optional).

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/description.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


4. Go to `Build` section and click on `Add build step`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/build-section.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


5. Select `Execute Shell` as a build step.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/execcute-shell.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


6. Copy and paste the following command into a `command` field.

```
date
```
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/command.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


7. Click on `Save`, it will redirect to job's view page.

8. On the left pane, click `Build Now` button to execute your job.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/buildnow.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


9. We can verify the history of executed build under the `Build History` by clicking the build number e.g: `#1`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/build%231.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


10. Click on build number and select `Console Output`. Here you can see the outputs of executed commands.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. In the above section we have created a freestyle project with `Execute Shell` as a build step.

## Freestyle with Parameterized Jobs

#### String Parameter 

1. Select `New Item` on the dashboard.

2. Enter the name of your project in the `Enter an item name` field, e.g: `Parameterized_Project_1`and select `Freestyle project` project , and click `OK` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/parameterized_project_1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter `Description` (optional).

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/description.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Under `General` section and you will find option `This project is parameterized` click the checkbox.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/select_parameterized.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. It will show you option to `Add Parameter`, select based on your requirement.

6. In this lab we select `String Parameter` and fill the required details.

	`Name:` **name**

	`Default Value:` **Testing**

	`Description:` **(optional)**    

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/parameter_content.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


7. Scroll down to `Build` section, select `Add build step` to add execute shell command.  

8. Copy and paste the following command into a `command` field.
`echo $name`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/echo_name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


9. Click on `Save`, it will redirect to job's view page. 

10. Click `Build With Parameters`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/build_with_perm.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


11. Default parameter value is displayed. You can change the value (optional).

12. Click `Build` button to execute your job.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/build_parameter.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


13. After execution is completed, we can verify the history of executed build by clicking build number e.g.: `#1` 

14. Click on build number and select `Console Output`. Here you can see the outputs of default parameter value.

15. You can see it has taken the parameter 'Testing' and printed 'Testing'.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/console_paramteter.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


16. You can also change the parameter, by clicking `Build with Parameters` option.

17. Change the parameter in name field `Hello World`, click `Build` button.

18. After execution is completed, we can verify the history of executed build by clicking build number e.g: `#2`

19. Click on build number and select `Console Output`. Here you can see the output of changed parameter.

In the above section we have created a freestyle project with string parameterized job.

#### Choice Parameter

1. Select `New Item` in the top left-hand corner on the dashboard.
2. Enter the name of your project in the `Enter an item name` field,  e.g: `Parameterized_Project_2` and select `Freestyle project`, and click `OK` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/parameterized_project_2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter `Description` (optional).

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/description.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Under `General` section and you will find option `This project is parameterized` click the checkbox  

5. It will show you option to `Add Parameter`, select parameter what you want. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/select_choice_parameter.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


6. Select `choice Parameter` and fill the required details

	`Name:` **number**

	`Choices:`  
One  
Two  
Three  
Four  
Five  

	`Description:` **Select one of them**

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/choice_parameter_details.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


7. Scroll down to `Build` section, select `Add build step` to add execute shell command.

8. Enter the command `echo $number` in command text area.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/execute_build_choice.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


9. Click on `Save`, it will redirect to job’s view page.

10. Click `Build With Parameters`.

11. You will find choice as a drop down. you can select any one of them. Here i can select `Two`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/two_choice.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


12. Click `Build` button to execute the project.

13. After execution is completed, we can verify the history of executed build by clicking build number e.g.: `#2`

14. Click on build number and select `Console Output`. Here you can see the output of choice parameter.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/two_console_output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

15. In the above section we have created a freestyle project with choice parameterized job.

## Upstream and Downstream Jobs

**What is Upstream Project**

Upstream project means that a build for the current job may be scheduled when an upstream build is finished. A project may have one or many upstream jobs.

**What is Downstream Project**

Downstream project means default every stable upstream job builds will schedule a build in the downstream jobs. A project may have one or many downstream jobs. 

Steps to create the Upstream and Downstream jobs

1. Click on `Jenkins' on the top left corner to list the jobs. 

2. Select the `project_1`  job and click `Configure` on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-configue.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. To configure upstream job go to `Build Triggers` section and select the `Build after other projects are built` option. 

4. Enter the Project name in `Project to watch` filed. and select the options.

5. By default `Trigger only if build is stable`, means it will trigger when the current job is succeeded. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-upstream.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


6. Scroll down to configure the downstream job `Post-build Actions` and click `Add Post build actions` button.  

7. Select `Build other Project` option and Add downstream project name in `Projects to build` field and select the options. 

8. By default `Trigger only if build is stable`, means it will trigger when the current job is succeeded.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-downstream.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


9. Click on `Save`, it will redirect to job’s dashboard You will see the upstream and downstream job name. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-list.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


10. Go to `parameterized_project_1` and on the left pane, click `Build Now` button to execute your job.  
11. After execution is completed, it will trigger downstream job, we can verify the history of executed build by clicking build number e.g: `#2`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-triggered-down-stream.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


12. Go to `Project_1` it will triggers downstream job `parameterized_project_2`, we can verify the history of executed build by clicking build number e.g.: `#3`  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-middle-job.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


13. Go to `parameterized_project_2`, we can verify the history of executed build by clicking build number e.g: `#3`  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/up-dw-downstream-console.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

14. In the above section we have created freestyle project and configured upstream and downstream job.

**Conclusion:** Congratulations! You have successfully completed the Jenkins Beginners lab. In this lab, you installed Jenkins, configure Jenkins and created freestyle jobs. Feel free to continue exploring or start a new lab. Thank you for taking this training lab!
