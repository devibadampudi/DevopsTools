# Securing Jenkins

## Table of contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Jenkins Global Security ](#jenkins-global-security)

[Login to Azure Portal](#login-to-azure-portal)

[Matrix-Based Security](#matrix-based-security)

[Project-Based Matrix Authorization Strategy](#project-based-matrix-authorization-strategy)

[Role-Based Strategy](#role-based-strategy)

## Overview

The aim of this lab is to understand the basic concepts of Securing Jenkins and Configuring Matrix Authorization, Project Authorization and Role-Based Authorization Plugins.

Jenkins is used everywhere from workstations on corporate intranets, to high-powered servers connected to the public internet. To safely support this wide spread of security and threat profiles, Jenkins offers many configuration options for enabling, editing, or disabling various security features.

As of Jenkins 2.0, many of the security options were enabled by default. The Enable Security section of the web UI allows a Jenkins administrator to enable, configure, or disable key security features which apply to the entire Jenkins environment.

## Pre-Requisites
Jenkins 2.x or later version.

Matrix Authorization Strategy Plugin 

## Jenkins Global Security

To securing jenkins one of the method is `Access Control`, which ensures users are authenticated when accessing Jenkins and their activities are authorized.
You should lock down the access to Jenkins UI so that users are authenticated and appropriate set of permissions are given to them. This setting is controlled mainly by two axes:
  * `Security Realm`: which determines users and their passwords, as well as what groups the users belong to.
  * `Authorization Strategy`: which determines who has access to what.
  
**Security Realm** 
we have different type of options in security realms in this lab we used `Jenkins’ own user database`

**Authorization Strategy** 
we have different type of options in authorization strategy in this lab we discuss  
* **Matrix-based security**  
* **Project-based Matrix Authorization Strategy**  
* **Role-Based Strategy** 

**Matrix-based security**
It allows you to grant specific permissions to users and groups. The available permissions are listed below with their descriptions, and are also available by hovering over the permission heading in the Jenkins UI.

**Project-based Matrix Authorization Strategy**
which we can define which user or group can do what actions on which job. This gives us a fine-grained control over user/group permissions per project

**Role-Based Strategy**
Enable you to assign different roles and privileges to different users.

## Login to Azure Portal

1. Using the Chrome browser, login into Azure portal with the below credentials.

 **Azure Email_ID:** {{azure-login-id}} 

 **Azure login_Password:** {{azure-login-password}}


<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on `Resource groups`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Selec the `{{resource-group-name}}` resource group.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Here you can see the list of resources .

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/azure7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


## Matrix-Based Security

**Login to Jenkins UI**

1. Open a new tab in chrome browser and login to the jenkins server by using below credentials.

    * **Jenkins url:** http://{{public_ip_address}}:8080
    * **Jenkins username:** {{Jenkins_UI_username}}
    * **Jenkins password:** {{Jenkins_UI_password}}

2. The setup wizard will ask you whether you want to install `suggested plugins` or you want to install `specific plugins`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/customize-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on `suggested plugins box`, and the plugins installation process will start.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/getting-started.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Once the plugins are installed, you will be prompted to set the URL for your Jenkins instance. The URL will be generated automatically. Confirm the URL by clicking `Save and Finish` button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/instance-configuration.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Once all the configurations are done, you can see the `Jenkins is ready` screen.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/jenkins-ready.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click `Start using Jenkins`, it will redirect to Jenkins dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/dashboard.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


7. Click on `Manage Jenkins` left corner on the jenkins dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Scroll down to `Manage Users` section.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-users.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Click on `Create User` on left corner on the jenkins  dashboard.  
10. Fill required details and click `Create User` button  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-create-user.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Likewise create one more user.  
12. After users created you will see the users list like below screenshot.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-users-list.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Click on `Manage Jenkins` option   
14. Select `Configure Global Security` view  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-configure-global-security.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

15. Click on `Matrix-based security`  radio button in Authorization field.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-matrix-based-security.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

16. To add users click on `Add user or group` button. Enter the usernames earlier we created click on `OK`.  
Ex. user1 and user2 
17. Select the permissions you want to assign to the particular user. in this lab we assign overall read and job level Read, Create, Configure and Build permissions.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-users-permissions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

18. Click on `Apply` and `Save`.   
19. Open `incognito` browser and enter jenkins IP http://{{public_ip_address}}:8080  
20. Login to the user and see you will get the permission or not   

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-user1-login.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

21. Create sample freestyle job and build.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-test-permissions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Project-Based Matrix Authorization Strategy

1. Click on `Manage Jenkins` left corner on the jenkins dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Select `Configure Global Security`  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-configure-global-security.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on `Project-based Matrix Authorization Strategy`  radio button in Authorization field.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. To add users click on `Add user or group` button. Enter the usernames earlier we created click on `OK`
5. Select the permissions you want to assign to the particular user. in this lab we assign overall read permissions.  
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix-permessions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on `Apply` and `Save`  
7. Create sample freestyle job  
Ex: Project-matrix 
8. Select the `Enable project-based security` option in general section  
9. To add users click on `Add user or group` button. Enterusername earlier we created click on `OK`.  
Ex. user1
10. Select the permissions you want to assign to the particular project. in this lab we assign `Read` and `Build` permissions.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix-job-permessions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Select  `Execute Shell`  as a build step and add shell command.  
12. Click on `Apply` and `Save`  
13. Open `incognito` and enter jenkins IP  
14. Login to the user and see you will get the permission or not   
  
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-user1-login.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

15. Build the job.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix-console.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

16. Create sample freestyle job  
Ex: Project-matrix-2
17. Select `Enable project-based security` and to add user click on `Add user or group` button. Enter `user2` click on `OK`  
18. Select the permissions in this lab we assign `Read` permissions.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix-job-user2-permissions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

19. Scroll down to `Build` section and click on  `Add build step`  
20. Select `Execute Shell` as a build step and add shell command.  
21. Click on `Apply` and `Save`  
22. Open `incognito` and enter jenkins IP  
23. Login to the user and see you will get the only Read permission.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-matrix-job-user2-console.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Role-Based Strategy

1. Click `Manage Jenkins` left corner on the jenkins dashboard.    

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Select `Manage Plugins` view  
3. Click on `Available` tab, Search `Role-based Authorization Strategy`.  
4. Select Role-based Authorization Strategy plugin and click `install without restart`.   

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-role-plugin.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Once the plugin is installed, a "success" message will be displayed.  
6. Go to `Manage Jenkins` and select `Configure Global Security`  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-configure-global-security.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Under `Authorization,` section  select `Role Based Strategy`. Click on `Save`.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-role-based-strategy.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Select `Manage and Assign Roles`.  
  
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-roles.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Click on `Manage Roles` to add new roles based on your organization.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-select-manage-roles-.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. Create a new role `testing`  
11. Enter role name `testing` in `Role to add` field and click `Add`.  
12. Select the permissions you want to assign to the particular role. in this lab we assign overall read and job level Read, Create, Configure and Build permissions.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-global-roles.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Click on `Apply` and `Save`  
14. Select `Assign Roles` Enter User name in `User/group to add` field   
15. Select `testing` role to added user.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-assign-roles.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

16. Click `Apply` and `Save`.

17. Open `incognito` browser and enter jenkins IP http://{{public_ip_address}}:8080

18. Login to the user and see you will get the permission or not   
19. Build the job.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-use1-roles-permissions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

20. Go to Admin user and `Manage Jenkins`.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-manage-jenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

21. Select `Manage and Assign Roles`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-select-manage-roles-.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

22. Create a new project specific roles under  `global Roles.`  
23. Enter role name `project-based`  in `Role to add` field and click `Add`.  
24. Select the permissions you want to assign to the particular role. in this lab we assign overall read permissions.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-based-global.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

25. You can create project specific roles under  `Project Roles.`  

26. Enter a role as "project-based". 

27. Add a pattern to this by adding `pro.`*, so that any username starting with "project" will be assigned the project role you specify.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-roles.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

28. Click `Add` and select pattern based permissions.  

29. Click `Apply` and `Save`.

30. Select `Assign Roles` To add global roles enter User name in `User/group to add` field.  

31. To add project roles enter username in `User/group to add` field and select role to added user.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-project-role-permissions.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

33. Click `Apply` and `Save`.

34. Open `incognito` browser and enter jenkins IP http://{{public_ip_address}}:8080

35. Login to the user2 and see you will get the jobs based on pattern prefix should be `pro`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/j-s-role-project-based-list.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

36. Select any one of the job and Run it.  

**Conclusion:** Congratulations! You have successfully completed the jenkins advance lab. In this lab, you created user and securing jenkins. Feel free to continue exploring or start a new lab.Thank you for taking this training lab!
