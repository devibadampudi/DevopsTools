# Jenkins Distributed Builds and Notifications

## Table of contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Jenkins Distributed Builds](#jenkins-distributed-builds)

[Setup Build Notifications](#setup-build-notifications)

[Manage Views](#manage-views)

## Overview 
The aim of this lab is to understand the Master and Slave Configuration, Setup Build Notifications and Manage Views in Jenkins.

Jenkins supports the master-slave architecture, i.e. many slaves work for a master and is known as Jenkins Distributed Builds. It allows you to run jobs on different environments like Linux, Windows, MacOS, etc. 

When there is a build failure or any changes in the build state, we must get notified so that the issues can be as soon as possible. In this lab we use `Mailer` plugin to configure notifications.

The main purpose of views is to display an organized subset of the jobs defined. Views can help us organize the jobs within Jenkins by categories and state. 

## Pre-Requisites

* Basic knowledge on Jenkins dashboard
* Gmail Account 

**Note** : Jenkins access is provided as part of the lab environment.

## Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on `My Account` and in the dropdown, select AWS Management console.

3. Use below credentials to login to AWS console.

    * Account ID: {{Account ID}}
    * IAM username: {{user name}}
    * Password: {{password}}
    * Region: {{region}}

4. Enter `Account ID` from the above information, then click on `Next`.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

5. Enter `IAM username` and `Password` from the above information.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

6. Once you provide all those information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select region as {{region}}.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

8. To see the Jenkins instance that is already provisioned for this lab. Click on `Services`, search for `EC2` and select `EC2` from the options.

9. Click on `running instances`, there you can see the Jenkins instance running. And also you can see the Jenkins network by navigation to the `VPC` services in the services tab.

##  Jenkins Distributed Builds

**Configure Jenkins Master and slave**

A Jenkins master comes with the basic installation of Jenkins and in this configuration the master handles all the tasks for your build system. 

If you are working on multiple projects, you may run multiple jobs on each and every project or some projects need to run on some particular nodes in this process we need to configure slaves. Jenkins slaves connect to the Jenkins master using Java Network Launch Protocol. 

**Jenkins Master and Slave Architecture** 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-architecture.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Jenkins master act to schedule the jobs and assign slaves and send builds to slaves to execute the jobs.


It will also monitor the slave state (offline or online) and getting back the build results responses from slaves and display build result on console output. The certain workload of building jobs are delegated to multiple `slaves`. 

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

### Configure Jenkins Master and slave

1. Click on `Manage Jenkins` on Jenkins dashboard.
2. Click on `Manage Nodes`. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-manage-node.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Select `New Node` enter the name of the node in `Node Name` field. e.g. test.
4. Select `Permanent Agent` and click `OK`.  
    * Initially you will get only one option `Permanent Agent`. Once you have one or more slaves you will get `Copy Existing Node` option.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-enter-node-name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter the required information.
* Some required fields.   
	* `Name`: Name of the Slave. `e.g.:` **Test**  

	* `Description`: Description for this slave (optional). `e.g.:` **testing slave** 
	
	* `# of Executors`:  Maximum number of Parallel builds Jenkins master perform on this slave. `e.g.:` **#4**

	* `Remote root directory`: A slave needs to have a directory dedicated to Jenkins. Specify the path to this directory on the agent. `e.g.:` **/home/**

	* `Usage`: Controls how Jenkins schedules builds on this node. `e.g.:` **Only build jobs with label expressions matching this node.**

	* `Launch method`: Controls how Jenkins starts this agent. `e.g.:`  **Launch agent agents via SSH**

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/dist_5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Enter the slave IP as {{slaveip}} in `Host` field as shown in below.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/dist_6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Select `Add` button to add credentials. and click `Jenkins`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/dist_7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Enter slave `Username, Password, ID and Description`.

`Username`: **{{slave-username}}**

`Password`: **{{slave-password}}**

`ID`: **user**

`Description`: **testing-slave**

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-add-creds.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Select drop down to add credential in `Credentials` field.
10. Select drop down to add Host Key Verification Strategy `Non verifying Verification Strategy`.
11. Select `Keep this agent online as much as possible` in Availability field.
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-configure-node.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. Click `Save` 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-slave-name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

###  Create a Freestyle job and Run on Slave machine.

1. Click `New Item` on the dashboard. 
2. Enter the name of your project in the `Enter an item name` field, select `Freestyle project` and click `OK` button.
3. Enter `Description` (optional). 
4. Select `Restrict where this project can be run` in general section.
5. Select the slave name in `Label Expression` field

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-job-configure.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Go to `Build` section and click on `Add build step`. Select `Execute Shell` as a build step.  
7. Here I am adding the shell commands. `e.g.:` **hostname**
8. Click on `Save`, it will redirect to job's view page
9. On the left pane, click `Build Now` button to execute your Pipeline.
10. We can verify the history of executed build under the `Build History` by clicking the build number.
11. Click on build number and select `Console Output`. Here you can see the executed job in remote host and output. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

###  Create a Pipeline and Run on Slave machine.

1. Click **New Item** on the dashboard.  
2. Enter the name of your project in the `Enter an item name`  field, and select  `Pipeline`  project , and click  `OK`  button. 
3. Enter `Description` (optional).  
4. Go to `Pipeline` section, make sure the `Definition` field has `Pipeline script` option selected. 
5. Copy and paste the following declarative Pipeline script into a `script` field. 

```
node('test'){
	stage('stage1') {
		sh '''echo  stage1 steps'''
	}
	stage('stage2') {
		sh '''echo stage2 steps'''
	}
	stage('stage3') {
		sh '''echo stage3 steps'''
	}
}

```
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-pipeline-script.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on `Save`, it will redirect to Pipeline view page. 
7. On the left pane, click `Build Now` button to execute your Pipeline. 
8. After Pipeline execution is completed, the Pipeline view will be as shown below.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-pipeline_view.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. We can verify the history of executed build under the `Build History` by clicking the build number.
10. Click on build number and select `Console Output`. Here you can see the outputs in each step. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/m-s-pipeline-console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

In the above section we have configure Jenkins master and slave with freestyle project and Pipeline. 

##  Setup Build Notifications

1. Click on `Manage Jenkins` on the dashboard. 
2. Click on `Configure System` 
3. Scroll down to `E-mail Notification` section.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-email-notification.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. In this lab we are using Gmail and Gmail SMTP server will be `smtp.gmail.com`
5. Click `Advanced` section, you will get extra fields. 
6. Select the checkbox `Use SMTP Authentication`.
7. Enter `Username` and `Password` of your personal Gmail account in username and password fields.
8. Enter `SMTP Port` for Gmail port will be `465`

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-configure-details.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Before testing email configuration login to your Gmail account and Allow less secure apps by clicking the following
 link [https://myaccount.google.com/lesssecureapps](https://myaccount.google.com/lesssecureapps)

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/allow_less_secure.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. Next test the email configuration, by clicking the `Test configuration by sending test e-mail` checkbox.
11. Enter anyother email address in `Test e-mail recipient` field. 
12. Next hit the `Test configuration` button, we will get the `Email was successfully sent` message.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-test-email-config.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Go to recipient email and check if you are got the test configuration email or not.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-test-email.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Configure Email Notification in your job 

1. Click `New Item` in the top left corner on the dashboard.
2. Enter the name of your project in the `Enter an item name` field, `e.g.:` **email_test** select `Freestyle project`, and click `OK`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/email-test-enter.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter `Description` (optional).
4. Go to `Build` section and click on `Add build step`. Select `Execute Shell` as a build step.  
5. Here we add the shell commands. `e.g.:` **echo test**
6. Scroll down to `Post-build Actions` section. 
7. Click `Add Post-build actions` button and select `E-mail Notification` option.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-select-email-notification.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Enter `Recipients Email address` in `Recipients` field and select the checkbox `Send e-mail for every unstable build` to send email alerts for every failure builds.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-recipents.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Click on `Save`, it will redirect to job's view page.  
10. On the left pane, click `Build Now` button to execute your Pipeline.
11. If the project build successfully, we don't get any email's if any build fails will get notified. 
12. Go to Build step and add `cho test` command 
13. Click on `Save`, it will redirect to job's view page.
14. On the left pane, click `Build Now` button to execute your Pipeline.
15. After execution is completed, we get email in recipient email address. 
16. We can verify the history of executed build under the `Build History` by clicking the build number e.g.: `#2`.
17. Click on build number and select `Console Output`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

18. Go to recipient email and check for job failure email.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/e-c-email-address-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

19. In the above section we have setup build notifications with Freestyle project and Pipelines. 

##  Manage Views

Jenkins views allow us to set up the jobs into a group. For example, you create a **Test** view, which displays testing specific jobs in it. If you have not created any views, then your system will be using the default **All** view.
* Two types of views on Jenkins
	* **List View**: List views shows items in a simple list format. You can choose which jobs are to be displayed in this view and you can add job filters.
	* **My View**: This view automatically displays all the jobs that the current user has access to. 

### Create a View

* In this lab we are creating `List view`.

1. Click on `New View` or `+` on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-create-views.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter the name of your view in `View name` field and select the `List view` and click `OK`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-list-view.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter the description of your view and add job filters (optional).  
4. Add the preferred jobs to this view by clicking the jobs checkbox.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-jobs-checkboxs.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Then Click `Apply` and `OK`, It will redirect to the view dashboard.
6. You will see the list of jobs what you selected in above steps.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-above-step.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

###  Update a View

1. Select the view what you want to update.
2. Click `Edit View` in the left corner on the view dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-edit-view.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Scroll down to `Add Column` button and select `Git Branches` option.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-git-branch.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Select the `Git Branches` field, and drag to top

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-dragto%20top.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Then `Apply` and `OK` it will redirect to view dashboard.
6. You will see the `Git Branches` option on view dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-git-branch-view-dashboard.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

###  Delete a View

1. Select the view you want to delete. It will redirect to `view` page.
2. Click `Delete view` on left corner.
3. It will open a pop-up window. Click `OK`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/v-delete-yes.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. It will redirect to Jenkins dashboard and you should see the view got deleted.

5. In the above section we have create, update and delete views. 

**Conclusion** Congratulations! You have successfully completed the Jenkins lab. In this lab, you configured master and slave machines and running jobs on slaves, build notifications, and manage views. Feel free to continue exploring or start a new lab. Thank you for taking this training lab!
