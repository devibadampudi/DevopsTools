# Jenkins Pipeline with NodeJS Application and Automated Code Coverage Tests

## Table of Contents

[Overview](#overview)

[Pre-requisites](#Pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create Pipeline for NodeJS Application](#create-pipeline-for-nodejs-application)

[Configure Webhooks](#configure-webhooks)

[Automate Code Coverage Test](#automate-code-coverage-test)


## Overview

The aim of this lab is to understand the process of Building a Sample NodeJS Application, Configure Webhooks and Automate the Code Coverage Test. 

In Continuous Integration after a code commit, the software is built and tested immediately. In a large project with many developers, commits are made many times during a day. With each commit code is built and tested. If the test is passed, build is tested for deployment. If deployment is a success, the code is pushed to production. This commit, build, test, and deploy is a continuous process and hence the name continuous integration/deployment.

A webhook is an HTTP callback, an HTTP POST that occurs when something happens through a simple event-notification via HTTP POST. GitHub webhooks in Jenkins are used to trigger the build whenever a developer commits code to the GitHub branch.

## Pre-Requisites
* Basic knowledge on Jenkins dashboard
* GitHub

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

## Create Pipeline for NodeJS application

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

#### Fork a NodeJS GitHub repository

1. Open new tab and `Login` with your `GitHub Account`.

2. On GitHub, navigate to the [krishnaprasadkv/Nodejs](https://github.com/krishnaprasadkv/Nodejs) repository.

3. In the top-right corner of the page, click `Fork`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/fork1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. That's it! Now, you have a fork of the original `krishnaprasadkv/Nodejs` repository.

#### Install NodeJS Plugin and configure version

1. Navigate to Jenkins tab and click `Manage Jenkins` on the dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-managejenkins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


2. Select `Manage Plugins` view  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-manageplugins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. Click on `Available` tab, search `NodeJS` plugin.

4. Select the `NodeJS` plugin and click `Install without restart`.   

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-plugins.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


5. Once plugin is installed you will get success message.  
6. Next click on `Manage Jenkins` on the dashboard.
7. Select `Global Tool Configuration` view.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-gloabaltool.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


8. Scroll down to `NodeJS` section.  
9. Add NodeJS version by clicking `Add NodeJS` button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-nodejs-add.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


10. Enter `node` in name field and select version.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-nodeversion.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


11. Click `Save` it redirects to Manage Jenkins page.

#### Create Pipeline 

1. Click `New Item` on the dashboard.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/new_item.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


2. Enter the name of your project in the `Enter an item name` field, select `Pipeline` project and click `OK` button. eg: node-js_pipeline.

3. Enter `Description` (optional).  

4.  Go to `Pipeline` section, make sure the `Definition` field has `Pipeline script` option selected. 

5. Copy and paste the following declarative pipeline script into a `script` field and update your `GitHub URL`.

```
pipeline {
  agent any
  tools {nodejs "node"}  
  stages {        
    stage('git_clone') {
      steps {
        git 'https://github.com/krishnaprasadkv/Nodejs.git'
      }
    }        
    stage('npm_install') {
      steps {
        // For installing npm
        sh 'npm install'
      }
    }     
    stage('npm_test') {
      steps {
        // For Test sample application.  
         sh 'npm test'
      }
    }      
  }
}
```

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-script-area.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


6. Click on `Save`, it redirects to pipeline view page.  
7. On the left pane, click `Build Now` button to execute your pipeline.
8. After pipeline execution is completed, the pipeline view will be as shown below. 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-pipelineview.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


9. We can verify the history of executed build under the `Build History` by clicking the build number e.g. `#1`.
10. Click on build number and select `Console Output`. Here you can see the outputs in each stage.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


11. Scroll down to the `npm_test` stage you will see the `test cases` results  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-testcases-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


## Configure Webhooks

1. We have to configure our Jenkins machine to communicate with our GitHub repository. For that we need to get the Hook URL of Jenkins machine.

2. Go to `Manage Jenkins` and select `Configure System` view.  

3. Find the `GitHub` Plugin Configuration section and click on `Advanced` button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-advanced.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


4. Select the `Specify another hook URL for GitHub configuration`  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-sepcify-hook.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Copy URL in the text box field and unselect it. 

6. Click `Save` it will redirect to the Jenkins dashboard.

7. Navigate to GitHub tab on browser and select your `GitHub` repository.  

8. Click on `Settings`. It will navigate to the repository settings.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-ghsettings.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Click on `Webhooks` section.   

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-webhooks.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


10. Click on `Add Webhook` button   
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-addwebhook.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


11. Paste the `Hook URL` on the `Payload URL` field.  

12. Make sure the `trigger webhook` field has `Just the push event` option selected. 

13. Click `Add webhook` it will add the webhook to your repository.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-webhook-options.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


14. Once you added webhook correctly. You can see the webhook with green tick.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-greentick.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


15. Next Jenkins configuration to run builds automatically when code is pushed to GitHub repository. Jenkins doesn’t run all builds for all projects. To specify which project builds, need to run, we have to modify the project configuration.

## Automate Code Coverage Test

1. Navigate to Jenkins tab and select the `node-js_pipeline` job

2. Click on `configure`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-configure.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


3. Go to `Build Triggers` section and select `GitHub hook trigger for GIT SCM polling`.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-jobconfiguration.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


4.  Click on `Save`, it will redirect to pipeline view page.
  
5. Go to GitHub and Update any of the file. In this lab we update `README.md` file.   

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-readme.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


6. Now see the Jenkins job will trigger automatically.  
 
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-buildtriggers.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. After pipeline execution is completed, we can verify the history of executed build under the `Build History` by clicking the build number e.g. `#2`.

8. Click on build number and select `Console Output`. Here you can see the outputs in each step.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Advanced/img/n-ci-hookconsole-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. In the above section we have created a Jenkins Pipeline with NodeJS Application and Automated Code Coverage Tests with 3 stages.

**Conclusion: ** Congratulations! You have successfully completed the Jenkins advance lab. In this lab, you created declarative pipeline and enable CI/CD. Feel free to continue exploring or start a new lab. Thank you for taking this training lab!
