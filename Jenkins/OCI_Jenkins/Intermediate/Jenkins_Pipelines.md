# Jenkins Pipelines

## Table of contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Pipeline Concepts](#pipeline-concepts)

[Login to OCI console](#login-to-oci-console)

[Basic Jenkins Pipeline](#basic-jenkins-pipeline)

[Pipeline with GitHub Project](#pipeline-with-github-project)

## Overview

The aim of this lab is to understand the basic concepts of Jenkins Pipelines and create a Declarative Pipeline using Pipeline script and Scripted Pipeline from Source Code Manager (SCM).

Pipelines are Jenkins jobs enabled by the Pipeline (formerly called “workflow”) plugin and built with simple text scripts that use a Pipeline DSL (domain-specific language) based on the Groovy programming language.

Pipelines leverage the power of multiple steps to execute both simple and complex tasks according to parameters that you establish. Once created, pipelines can build code and orchestrate the work required to drive applications from commit to delivery.

## Pre-Requisites

* Basic knowledge on Jenkins dashboard

**Note** : Jenkins access is provided as part of the lab environment.

## Pipeline Concepts

**Jenkinsfile**

Jenkins pipelines can be defined using a text file called **JenkinsFile**. You can implement pipeline as code using JenkinsFile, and this can be defined by using a domain specific language (DSL). With Jenkinsfile, you can write the steps needed for running a Jenkins pipeline.

The benefits of using Jenkinsfile are:

* Code review/iteration on the Pipeline.
* Audit trail for the Pipeline.
* Single source of truth for the Pipeline, which can be viewed and edited by multiple members of the project.

**Jenkins Pipeline is supported in two types of syntax: **

* Declarative

* Scripted

#### Pipeline Concepts

The following are fundamentals of Jenkins pipeline.

*  **Pipeline**: A pipeline is a user-defined model of a continuous delivery (CD). A Pipeline’s code defines your entire build process, which includes stages for build, test and deliver the application. It is a part of declarative pipeline.

*  **Node**: A node is a machine on which Jenkins runs. Node block is mainly used in scripted pipeline.

*  **Stage**: A stage contains a series of tasks performed through entire pipeline, that is, build, test, and deploy. A stage block can visualize your Jenkins pipeline status.

*  **Step**: A step is nothing but a single task that executes a specific process at a particular point of time. This block is used in declarative pipeline.

**Declarative Pipeline**

Declarative Pipeline brings a simple and user-friendly syntax with some specific statements. Declarative pipeline should start with *pipeline* sentence and follow the required sections:

* Agent

* Stages

* Stage

* Steps  

Sample declarative pipeline example: -

```
pipeline {
	agent any
		stages {
			stage('stage1') {
				steps {
					// stage1 steps
				}
			}
			stage('stage2') {
				steps {
					// stage2 steps
				}
			}
			stage('stage3') {
				steps {
					// stage3 steps
				}
			}
		}
	}
```

**Scripted Pipeline**

Scripted Pipeline provides flexibility and extensibility to Jenkins users. It starts with *node*.

Sample Scripted Pipeline example: -

```
node{
     stage('stage1') {
		// stage1 steps
     }
     stage('stage2') {
		// stage2 steps
     }
     stage('stage3') {
	  	// stage3 steps
     }
     
}
```
* Both Declarative and Scripted Pipeline are written in Domain Specific Language (DSLs) to describe a piece of your software delivery pipeline. Scripted Pipeline is written in a limited form of Groovy syntax.

* A Pipeline can be created in two ways:

	*  **Classic UI** You can write pipeline script directly in Jenkins UI.

	*  **SCM** In Source Code Management, you can write a Jenkinsfile manually and commit into project source code repository.
	
## Login to OCI Console

In this section we will login to the OCI console

1.Sign in to your OCI account using your credentials 

* **Cloud Tenant:** {{Cloud_Tenant}}
* **User Name:** {{User_Name}}
* **Password:** {{Password}}

2.Enter the Cloud Tenanat name

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter user name and password

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Reduce the browser display size  as needed
           (Below example is for Chrome). 

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. From OCI Services menu, choose `Compute` --> `Instances`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


* **Compartment Name:** {{compartment_name}}


6. Choose correct `compartment` name as mentioned above.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Beginners/img/oci5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Here you can see the Jenkins instance running

## Basic Jenkins Pipeline

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

#### Declarative Pipeline with Classic UI

Steps to create sample pipeline in classic UI.

1. Click `New Item` in the top left corner on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/new_item.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter the name of your project in the `Enter an item name` field, select `Pipeline` project and click `OK` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/entername.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D"  alt="image-alt-text" >

3. Enter `Description` (optional).

4. Go to `Pipeline` section, make sure the `Definition` field has `Pipeline script` option selected.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/definition.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D"  alt="image-alt-text" >

5. Copy and paste the following declarative pipeline script into a `script` field.

```
pipeline {
	agent any
		stages {
			stage('stage1') {
				steps {
					sh '''echo stage1 steps'''
				}
			}
			stage('stage2') {
				steps {
					sh '''echo stage2 steps'''
				}
			}
			stage('stage3') {
				steps {
					sh '''echo stage3 steps'''
				}
			}	
		}
	}

```
<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/pipeline_script.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on `Save`, it will redirect to pipeline view page.

7. On the left pane, click `Build Now` button to execute your pipeline.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/build_now.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. After pipeline execution is completed, the pipeline view will be as shown below.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/pipeline_view.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. We can verify the history of executed build under the `Build History` by clicking the build number e.g: `#1`.

10. Click on build number and select `Console Output`. Here you can see the outputs in each steps.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/console_output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. In the above section we have created a declarative pipeline with 3 stages having one step in each stage.

#### Scripted Pipeline with SCM

Steps to create sample pipeline with SCM.

1. Click **New Item** in the top left corner on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/new_item.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter the name of your project in the `Enter an item name` field, and select `Pipeline` project, and click `OK` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/jenkinsfile_name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter `Description` (optional).

4. Go to pipeline section, in `Definition` field choose `Pipeline script from SCM`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/choose_selectscm.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Select `git` for SCM option.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/choose_git.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. For this lab we already created Jenkinsfile. Open https://raw.githubusercontent.com/sysgain/qloudable_Jenkinsfile/master/Jenkinsfile URL in browser 

7. In `Repository URL` enter `https://github.com/sysgain/qloudable_Jenkinsfile.git`.

8. In the `Script Path` make sure `Jenkinsfile` is entered.

9. Click on `Save`, it will redirect to pipeline view page.

10. On the left pane, click `Build Now` button to execute your pipeline.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/build_now_jenkinsfile.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. After pipeline execution is completed, the pipeline view will be as shown below.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/pipeline_view_jenkinsfile.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. We can verify the history of executed build under the `Build History` by clicking the build number e.g: `#1`.

13. Click on build number and select `Console Output`. Here you can see the outputs in each stage.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/console_output_jenkinsfile.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

14. In the above section we have created a Scripted pipeline with 3 stages having one step in each stage.

#### Deletion of Pipeline

Steps to delete a pipeline.

1. Select the pipeline you want to delete. It will redirect to pipeline view page.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/select_pipeline_delete.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click `Delete Pipeline` on left corner.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/delete_pipeline.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. It will open a pop-up window. Click `OK`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/pop-up_delete.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. It will redirect to Jenkins dashboard and you should see the pipeline got deleted.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/last_dashboard.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Pipeline with GitHub Project

Steps to create pipeline with GitHub project.

1. Click `New Item` in the top left corner on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/new_item.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter the name of your project in the `Enter an item name`  field, select  `Pipeline`  project and click  `OK`.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/p-gh-enter-name.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Enter `description` (optional).

4. Go to `Pipeline` section, make sure the `Definition` field has `Pipeline script` option selected.

5. Copy and paste the following Scripted pipeline script into a `Script` field.

```
node('master'){
	stage('git_clone') {
	git (url: 'https://github.com/sysgain/qloudable_Jenkinsfile.git', branch: 'master')
	sh "git status"
	}
	stage('list_of_files') {
		sh "ls -ltr"
	}
	stage('list_of_branches') {
	sh "git branch"
	}
}
```
6. Following are the stages in the Pipeline script. 

	 * git_clone stage: Clone the repository into your local. 

	 * list_of_files stage: List the files and folders in that repository.

	 * list_of_branches stage: List of branches given repository.  

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/p-gh-scriptarea.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Click on `Save`, it will redirect to pipeline view page.  

8. On the left pane, click `Build Now` button to execute your pipeline.

9. After pipeline execution is completed, the pipeline view will be as shown below.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/p-gh-pipeline-view.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. We can verify the history of executed build under the `Build History` by clicking the build number e.g: `#1`.

11 Click on build number and select `console output`, Here you can see the outputs in each stage.

<img src="https://qloudableassets.blob.core.windows.net/devops/Jenkins/Generic/Intermediate/img/p-gh-console-output.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. In the above section we have created a Scripted pipeline with GitHub project with 3 stages having one step in each stage.

**Conclusion: ** Congratulations! You have successfully completed the Jenkins pipeline lab. In this lab, you created Declarative Pipeline, Scripted Pipeline, Pipeline deletion and Scripted Pipeline with git hub project. Feel free to continue exploring or start a new lab. Thank you for taking this training lab!.
