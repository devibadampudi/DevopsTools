# INTRODUCTION TO ANSIBLE

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS console](#login-to-aws-console)

[Login to the Instance and Install Ansible](#login-to-the-instance-and-install-ansible)

[Creating SSH Keys for Ansible to access other instances](#creating-ssh-keys-for-ansible-to-access-other-instances)

[create a ansible playbook](#create-a-ansible-playbook)

[Conditions in Ansible](#conditions-in-ansible)

[Loops and Variables in Ansible](#loops-and-variables-in-ansible)

## Overview

## Pre-Requisites

1) Basic knowledge of Linux servers

2) YAML language

3) SSH private/public key knowledge

## Login to AWS console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on `My Account` and in the dropdown, select AWS Management console.

3. Use below credentials to login to AWS console.

    * Account ID: {{Account ID}}
    * IAM username: {{user name}}
    * Password: {{password}}
    * Region: {{region}}
 

4. Enter `Account ID` from the above information, then click on `Next`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter `IAM username` and `Password` from the above information.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once you provide all those information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select region as {{region}}.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. To see the ansible instance that is already provisioned for this lab. Click on `Services`, search for `EC2` and select `EC2` from the options. And also you can see the instance network by navigation to the `VPC` services in the services tab.

9. Click on `running instances`, there you can see the ansible instance running. Click ansible instalce and make sure copy the IP of instace for forther use.

## Login to the Instance and Install Ansible

In this section we will SSH into the Created instance and Configure the Ansible. 

**Step 1.**
Open putty from applications drop-down at top-left corner of the workspace.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Connect using the IP of "Ansible Server VM" and use the below credentials.
 
Server setup:

**Login as: {{instance username}}**<br>
**Password: {{instance password}}**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 2.**  We now have a EC2 instance in AWS with a Public IP  address which is accessible over the internet. 

**Step 3.** The "sudo" command allows user to run programs with elevated privileges and "su" command allows you to become another user. Running the following command will default to root account(system administrator account) which allows installing and configuring ansible using apt-get package manager.

```sudo su - ```

```apt-add-repository ppa:ansible/ansible -y ```

```apt-get update```

```apt-get install -y ansible```
 
**Note:** Along with Anisble package, multiple pre-requisite packages are being installed which takes a couple of minutes.


**Step 3.** Ansible has a default inventory file created which is located at "/etc/ansible/hosts". Inventory file contains a list of nodes which are managed/configured by ansible.

It is always a good practice to back up the default inventory file to reference it in future if required.

Run the following commands to move and create a new inventory file

```sudo mv /etc/ansible/hosts /etc/ansible/hosts.orig```

```sudo touch /etc/ansible/hosts```

```vi /etc/ansible/hosts```

**Step 4.** Update the created hosts file in the step 8 with the following data

Press i to change vi editor to insert mode then copy and past the below lines to hosts file. Afer updating the file, press Esc wq to save save and quit the file.
```
[local]
127.0.0.1
```
**Step 5.** In the Step 9, we have added local server's ip address(127.0.0.1) to the hosts inventory file, ansible uses the host file to SSH into the servers and run the required ansible jobs.

**Step 6.** To validate Ansible is installed and configured correctly, run the following command

 ```ansible --version```

**Note:** It is ok, if the above command returns different version of ansible. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Creating SSH Keys for Ansible to access other instances

In this section, We will create a public and private SSH key pairs for ansible control machine to SSH into the nodes defined in inventory file.

Ansible control machine is a server on which ansible is installed and executes ansible tasks on the managed nodes.

An inventory file is a list of managed nodes which are also called "hosts". Ansible is not installed on managed nodes.

**Step 1.** In the terminal, enter the command ```ssh-keygen```

Press **"Enter"**, when asked for the following 

  a) Enter file in which to save the key 

  b) Enter passphrase

  c) Enter passphrase again

**Tip**
No Passphrase is required.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 2.** Public and Private keys should have been generated and are stored in the directory /root/.ssh/. Public key need to be copied to authorized keys file, which gives ansible access to login into the managed node.

**Note:**
In this example Ansible control machine and the managed node is the same server. If authorized_keys file is already available, overwrite it with the public key or a new file is generated.


Execute the following commands to copy the public key

```cd /root/.ssh```

```cp id_rsa.pub authorized_keys```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


**Step 3.** Check to see if Ansible is able to connect to the servers, defined in the inventory file that was created in the previous section. 

Execute the following command which pings the servers in the inventory file.

```ansible all -m ping```

Enter "yes" when prompted to add server ip to the known_hosts file. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Above command pings the servers defined in the inventory file that is created in the previous steps. Since only local machine is added in the inventory file ansible does a ping on the local machine using the SSH key created. 

## create a ansible playbook

In this section, We will learn what an ansible playbook is and how to create and execute a playbook which installs a package on the server.

Ansible Playbook are the files where ansible code is written. They are written in YAML format. Playbooks contains the tasks which the user wants to execute on a particular machine. Multiple tasks can be specified in a playbook which are executed sequentially.

**Important:-**
Both Ansible control machine and managed node are same in this tutorial. All the packages that are being installed and managed are done on the same machine. 

**Step 1.** Create a folder named Ansible and store all the playbooks that are required in this tutorial. Create a YAML file inside the folder using the following commands

```mkdir /root/ansible``` <br>
```cd /root/ansible```<br
```vi install_package.yaml```

**Step 2.** Copy/Type the following code into the created install_package.yaml file 

```yml
---
- hosts: local
  tasks:
     - name: install apache2
       apt: name=apache2 update_cache=yes state=latest
     - name: start apache2
       service: name=apache2 state=started
```

**Step 3.** In the above code, hosts section is mandatory to determine where the playbook needs to be executed. This can be a server name or a group of servers that are defined in the inventory file(created in previous section).  A group named local was defined in the inventory file in the previous section. Ansible runs this playbook on the servers defined under local group. 


**Step 4.** Run the command ```ansible-playbook  install_package.yaml``` Ansible checks the inventory file for the local group and installs the package apache2 with latest version on the servers. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 5.** From the output, there were 2 tasks run in the playbook , first is gathering facts. Ansible gathers facts of the server on which playbook is running and then executes the tasks defined in the playbook which is installing apache2 package. 

**Step 6.** To validate if apache2 is installed on the server, type the command ```service apache2 status```. 


## Conditions in Ansible

In this section, we will learn how Ansible conditions work and how they can be used inside Ansible playbooks to perform conditional tasks.  

In this example, we will check the system facts and install specified package on respective operating system.

**Step 1.** Create a new file condition.yaml with the command "touch /root/ansible/condition.yaml"

**Step 2.**  Ansible collects the facts before executing a playbook on the server. These facts are the attributes of the machine.

To list all the default facts of the machine run the following code:

```ansible -m setup local```

This command prints all the facts that ansible collects about the machine. If you want it to display single fact, use grep.

The following command displays ansible distribution facts which playbook collects before execution: 

```ansible -m setup local | grep ansible_distribution```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 3.** Create a new file with the command ```vim /root/ansible/condition.yaml``` Add the following code into the file. 

**Note:**
Remove apache2 package on the server using ```apt-get remove -y apache2```

```yml
---
- hosts: local
  tasks:
      - name: install apache on ubuntu servers
        apt:  name=apache2 state=present
        when: (ansible_facts['distribution'] == "Ubuntu")
        register: output1

      - name: Show output of the registered value
        debug: var=output1

      - name: install apache on centos servers
        yum: name=httpd state=present
        when: (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "7")
        register: output2

      - name: show output of registerd value
        debug: var=output2

```
**Step 4.** The tasks in the above code will check the OS type and installs apache/httpd package accordingly, ansible playbook skips the task if condition fails. Register in the task will store output of task to a variable and debug task will display the output of task.

```ansible-playbook  condition.yaml```
 

## Loops and Variables in Ansible

In this section, we will discuss about the variables and loops in Ansible playbooks. Loops are used if a same task needs to be executed multiple times like creating multiple users, installing multiple packages etc.

**Step 1.** create a playbook  ```vim /root/ansible/install_packages.yaml``` and add below content to it.

```yaml
---
- hosts: local
  vars:
    packages:
       - wget
       - apache2
       - telnet
  tasks:
     - name: instal packages
       apt: name="{{item}}" state=latest
       with_items: "{{packages}}"
```

**Step 2.** Packages are defined in a list variable and the variable is used in the task to install multiple packages at the same time. With_items iterates overs the list variable "packages" and stores the value in a temperory variable "item". apt task is executed on each item from the packages variable. 

**Step 3.** If the packages are already installed on the server, Ansible skips installation of the specific package, to validate the playbook installs the required packages, they can be removed with the command

```apt remove -y wget telnet apache2```

**Step 4.** Execute the playbook using the command ```ansible-playbook  install_packages.yaml``` to install the packages

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 5.** All the packages are installed on the server. To verify if the package is installed run the command:

```apt list <<package_name>>```


Conclusion:

Congratulations!

You have successfully completed the Introduction to Ansible lab! In this tutorial we have Created a instance in AWS. 

We have learnt basics of Ansible on how to install Ansible and manage the configuration using Ansible. We have used Ansible playbooks to install multiple packages, store values inside variables, loops and conditions in Ansible. Finally we have installed and configured apache on a server and started the Apache service. 

Feel free to continue exploring or start a new lab. 

Thank you for taking this self-paced lab!