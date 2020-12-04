# ADVANCED ANSIBLE PLAYBOOKS

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to the Azure portal](#login-to-the-azure-portal)

[Launch Instance for Ansible ](#launch-instance-for-Ansible )

[Login to the Instance and Install Ansible](#login-to-the-instance-and-install-ansible)

[Creating SSH Keys for Ansible to access other instances](#creating-ssh-keys-for-ansible-to-access-other-instances)

[Asynchronous actions and polling of a task in Ansible Playbook](#asynchronous-actions-and-polling-of-a-task-in-ansible-playbook)

[Task Delegation and Rolling Updates](#task-delegation-and-rolling-updates)

[Blocks for error handling in Ansible Playbooks](#blocks-for-error-handling-in-ansible-playbooks)

[Encrypt sensitive data using Vaults](#encrypt-sensitive-data-using-vaults)

## Overview


Ansible Playbooks are an organized unit of scripts that is used for server configuration management by the automation tool Ansible. Ansible Playbooks are used to automate the configuration of multiple servers at a time. Playbooks are written in YAML format.

Playbook contains one or more plays/tasks which executes a simple command or a script. Every playbook has an attribute hosts, where servers or group of servers are defined. These plays are executed in sequencial manner on the servers defined in the playbook.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/01.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

It is possible to run several hundreds of tasks in a single playbook, but it is efficient to reuse a task multiple time in multiple playbooks so tasks or group of tasks can be organized into roles. These roles can be included into a playbook. In this tutorial we will learning about how the tasks in a role are executed in asynchronous mode and how they can be polled later during the playbook execution.

We will learn about task delegation to another server, for example in a playbook certain tasks can be executed on a different server than the server on which playbook is executed. We will learn about how to use blocks for error handing in a playbook and to encrypt sensitive data using Ansible Vault feature. 

Click Start above to begin the lab!

## Pre-Requisites
1) Basic knowledge of Linux servers

2) YAML language

3) SSH private/public key knowledge

4) Basic knowledge of ansible.

## Login to the Azure portal

In the lab console window, use the web browser and go to https://portal.azure.com

Azure login_ID: {{azure-login-id}}<br>
Azure login_Password: {{azure-login-password}}<br>
Resource group Name: {{resource-group-name}}<br>
location: {{azure-rg-location}}

For login credentials click on access info left top of context window. Click on required value To copy to clip board and past it on worksapace window.

Enter the username provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Enter the password Provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The dashboard of the Azure portal will Appear after a successful login.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Launch Instance for Ansible 

In this section we will create a Ubuntu server to install Ansible on it.


Launching a VM:

Step 1: On Azure portal (https://portal.azure.com), click on **"Create a resource"** from the navigation pane.

Step 2: Search for "Ubuntu Server", select Canonical "Ubuntu 16.04 LTS" from the dropdown and click on create.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3: Leaving the default values untouched, Fill the form as below.
Resource group: Select the name of RG shared with your login credentials.<br>
Virtual Machine Name: Any name (ansible)<br>
Authentication type: Password <br>
Username: ansible<br>
Password: Password@1234<br>
size: Standard Ds1 v2<br>
Public inbound ports: Check the radio button "Allow selected ports" and allow ports 22 from the dropdown.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4: On the next steps "Disks and Networking", Leave all fields to defaults and proceed to the Management tab.

Step 5: Set the "Boot Diagnostics" to 'Off' and proceed over to the final step "Review and Create" and click on create after you see that the validation succeeds.


Step 6. Follow the step 1 to step 5 again to create another instance.

Step 7: Afeter completion of deployment goto your resource group and clik on Virtual machine. Do copy  server ip for future use.

## Login to the Instance and Install Ansible

In this section we will SSH into the Created instance and Configure the Ansible. 

**Step 1.**
Open putty from applications drop-down at top-left corner of the workspace.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Connect using the IP of "Ansible Server VM" and use the credentials you provided when creating the VM.
 
Server setup:

**Login as: ansible**<br>
**Password: Password@1234**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.**  We now have a Compute instance in Azure with a Public IP  address which is accessible over the internet. 

**Step 3.** The "sudo" command allows user to run programs with elevated privileges and "su" command allows you to become another user. Running the following command will default to root account(system administrator account) which allows installing and configuring ansible using apt-get package manager.

```sh
sudo su -
apt-add-repository ppa:ansible/ansible -y
apt-get update
apt-get install -y ansible
```

**Note:** Along with Anisble package, multiple pre-requisite packages are being installed which takes a couple of minutes.


**Step 3.** Ansible has a default inventory file created which is located at "/etc/ansible/hosts". Inventory file contains a list of nodes which are managed/configured by ansible.

It is always a good practice to back up the default inventory file to reference it in future if required.

Run the following commands to move and create a new inventory file

```sh
mv /etc/ansible/hosts /etc/ansible/hosts.orig
touch /etc/ansible/hosts
vi /etc/ansible/hosts
```

**Step 4.** Update the created hosts file  with the following data (replace ipaddress with second server IP):

```sh
[local]
127.0.0.1
[webserver]
<<ipaddress of second server>>
 ```
![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 5.** In the above Step, we have added local server's ip address (127.0.0.1) and the second server (public IP address) to the hosts inventory file, Ansible uses the host file to SSH into the servers and run the requiredAansible jobs.

**Step 6.** To validate Ansible is installed and configured correctly, run the following command:

```ansible --version```

**Note:** It is ok, if the above command returns different version of ansible. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Creating SSH Keys for Ansible to access other instances

In this section, we will create a public and private SSH key pairs for ansible control machine to SSH into the nodes defined in inventory file.

Ansible control machine is a server on which Ansible is installed and executes Ansible tasks on the managed nodes.

An inventory file is a list of managed nodes which are also called "hosts". Ansible is not installed on managed nodes.

**Step 1.** In the terminal of Ansible Control Machine (where ansible is installed), enter the command ```ssh-keygen```

Press "Enter", when asked for the following:

    a) Enter file in which to save the key 

    b) Enter passphrase

    c) Enter passphrase again

**Tip:** No Passphrase is required.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.** Public and Private keys should have been generated and are stored in the directory /root/.ssh/. Public key need to be copied to authorized keys file, which gives Ansible access to login into the managed node.

**Note:** In this example Ansible control machine and the managed node is the same server. If authorized_keys file is already available, overwrite it with the public key or a new file is generated.


Execute the following commands to copy the public key:

```cd /root/.ssh```

```cp id_rsa.pub authorized_keys```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 3.** Open authorized_keys and copy the data using the following command:

``` cat /root/.ssh/authorized_keys```
            
Highlight the SSH key and copy (using the mouse)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 4.** Login to second server, there we need to paste the copied public key to the authorized keys file . Follow the steps to copy the public key:

**Tip:** You can swap between the workspace windows (Putty,Notepad etc.) by clicking the Switch Window icon.

```sh
sudo su -
cd /root/.ssh/
vi authorized_keys
```
Copy the key into authorized_keys file 
 

**Note:** The public key needs to be copied into authorized_keys file in all servers(nodes) so that ansible control machine can SSH into the machines.

**Step 5.** In the Ansible Control Machine, Check to see if Ansible is able to connect to the servers, defined in the inventory file that was created in the previous section. Execute the following command which pings the servers in the inventory file.

```ansible all -m ping```

Enter "yes" when prompted to add server ip to the known_hosts file. You might need to type twice as 2 hosts are added to the known_hosts file.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Above command pings the servers defined in the inventory file that is created in the previous steps. Since only local machine is added in the inventory file ansible does a ping on the local machine using the SSH key created. 

## Asynchronous actions and polling of a task in Ansible Playbook

All the tasks in a playbook by default are executed synchronously. Tasks in a playbook that are not related to each other can be run asynchronously to avoid blocking or timeout issues. In Asynchronous mode all the tasks are executed at once and then poll until they are completed. In asynchronous mode maximun runtime of a task and how freqently you would like to poll need to be specified. 

Step 1. Create a folder named Ansible and store all the playbooks that are required in this tutorial. Create a YAML file inside the folder using the following commands

```sh
mkdir /root/ansible
cd /root/ansible
vi async.yaml
```

Step 2. Copy the following code into the created async.yaml file 

```yml
---
- hosts: local
  tasks:
    - name: Sleep for 15 sec
      command: /bin/sleep 15
      async: 45
      poll: 0

    - name: Install apache2
      yum:
        name: apache2
        state: present
      async: 60
      poll: 0
      become: true
```

Step 3. In the above code, hosts section is mandatory to determine where the playbook needs to be executed. If async keyword is not defined in the playbook, the task runs synchronously, specify the maximum time for async keywork for the command to execute in asynchrous mode, poll value determines the number of seconds the tasks waits before moving to the next task. Default value of poll is 10 seconds. Specify the value of poll to 0 for the execution to move forward without waiting for the task to complete.

**Note:** Operation that require locks should not be attempted to run with poll value 0 if you want to run other tasks in the playbooks that requires same resources. 

Step 4: Run the command to execute the playbook

``` ansible-playbook async.yaml```

You can see that the execution of the playbook does not stop for 15 seconds but completes the playbook execution.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


Step 5. Asynchronous tasks can be checked later in the playbook if the task has been completed. Update the file with the following code. 

```vi async2.yaml```

```yml
---
- hosts: local
  tasks:
    - name: sleep for 30 seconds
      command: /bin/sleep 30
      async: 1000
      poll: 0
      register: sleeper

    - name: check on asyn task
      async_status:
        jid: "{{ sleeper.ansible_job_id }}"
      register: job_result
      until: job_result.finished
      retries: 10
```

Execute the playbook with the command **```ansible-playbook async2.yaml```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 6. In the above execution, the task when was performed asynchronously was to sleep for 30 seconds. In the next task we checked to see if the above task was completed. Status of the command "Sleep 30 seconds" were tried for 5 times before it finished the task.

## Task Delegation and Rolling Updates

In this section, we will learn about task delegation. In a playbook, if a perticular task needs to be performed on another host, "delegate_to" keyword can be used. This remote execution of a task is part of a playbook and is executed on another specified host.

Step 1: Create a new file under the folder ansible with the following command

```vi /root/ansible/delegation.yaml```<br>
Update the above created file with the below code and replace "delegate_to" value with publicIp of ansible node 

```yml
---
- hosts: local
  tasks:
    - name: install apache2
      apt:
        name: apache2
        state: present
      delegate_to: <ansible node IP>
```
![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 2.  In the above code we run this playbook on local host which is mentioned in the hosts section on the play. But since this task is being delegated to the node "ansiblenode" which was defined in the host section. This task is executed on the ansible node and apache2 is installed on ansible node.

Step 3. Execute the playbook with the command 

```ansible-playbook /root/ansible/delegation.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

As we can see in the execution output that the task was delegated to a different node and apache2 was installed on remote machine.

### Rolling Updates

Step 4. By default, Ansible will manage all the machines referenced in a play in parallel. If the playbook needs to be executed in rolling update use case. It can be managed by using "serial" keyword in the play. Ansible uses the number specified in the keyword and executes those many servers in parallel. 

Step 5. create ```vi /root/ansible/rolling_updates.yaml``` file with the following code, to run the playbook in rolling update for each server.

```yml
---
- hosts: all
  tasks:
    - name: install apache2
      apt:
        name: apache2
        state: present
  serial: 1
```

In the above code we defined serial as 1 which states that only 1 server is executed at a time. 

Step 6.  Execute the playbook with the following command 

```ansible-playbook rolling_updates.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution output, first apache2 is installed in the local machine and then it is installed on the remote machine. 

Rolling update can even be defined, if there are different batch of servers that needs to be executed for example

```yml
- name: batch execution
  hosts: all
  serial:
    - 1
    - 5
    - 10 
```

In the above code the task is executed in baches, the first batch would contain a single host, the next would contain 5 hosts, and the remaining batches would contain 10 hosts untill all the available hosts completes task execution. 

## Blocks for error handling in Ansible Playbooks

Blocks allow for logical grouping of tasks and in play error handling. Multiple tasks are grouped into a section named "blocks" and if any of the tasks in the block fails, "rescue" section tasks are executed. The section "always" is executed everytime irrespective of an error either in the block or rescue section.

Step 1: Create a new playbook under the folder ansible with the following command

```vi /root/ansible/blocks.yaml```

Update the created file with the following code

```yml
---
- hosts: local
  tasks:
    - name: Attempt and graceful rollback 
      block:
        - debug:
             msg: 'I execute normally'
        - command: /bin/false
        - debug:
             msg: 'I never execute, due to the above failing command'
      rescue:
        - debug:
             msg: 'I caught an error'
      always:
        - debug:
             msg: ' I always execute'
```

In the block section, "command: /bin/false"  fails to execute and the execution is transferred to the rescue section, where all the tasks under it are executed before proceeding to "always" section.

Step 2.  Execute the playbook with the command 

```ansible-playbook /root/ansible/blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution output, we can see that the tasks executed after the error are in the "rescue" section and "block" section.

Step 3. We will update the file "blocks.yaml" with the following code so that it passes execution in the "block" section and continous to execute "always" section.

Changing the command from "/bin/false" to "/bin/true" will pass execution in the block section and always section code is executed. 

```vi  /root/ansible/blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4.  Execute the playbook with the command 

```ansible-playbook blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Encrypt sensitive data using Vaults

In this section, we will learn about Ansible vault and how it is used to encrypt sensitive data(usernames and passwords). Ansible vault is a feature of ansible which can encrypt any structured data file used by Ansible. In the steps below, we will see how a playbook can be encrypted with a password and how the encrypted playbooks are executed. 

Step 1: Create a new file  "encrypt.yaml" under the folder ansible with the command

```vi /root/ansible/encrypt.yaml```

Step 2: Update the file with the following code 

```yml
---
- hosts: local
  tasks:
    - name: Print Username and password
      debug:
        msg: ' Username is Sysgain123 and Password is Ansible123'
```

In this above file Username and Password are sensitive data and cannot be stored as a plain text. Ansible vault feature helps us to encrypt the playbook.

Step 3: Encrypt the playbook with the following command

```ansible-vault encrypt encrypt.yaml```

In the above command, ansible-vault is a feature of ansible, encrypt is the keyword used to encrypt a file and encrypt.yaml is the filename which is being encrypted. 

Command prompts to enter the password, type the password and type "Enter".  Type the same password again when asked to confirm. 

**Note:** Password that is being entered is not visible.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4. Open the encrypted file and it looks similar to the following image

```vi /root/ansible/encrypt.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 5. Execute the playbook with the following command

```ansible-playbook encrypt.yaml --ask-vault-pass```

The above command prompts for a password and type the same password used to encrypt the file. Ansible decrypts the file and the playbook is executed. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 6. If the playbook needs to be updated it can be decrypted using the following command and the passord provided during encryption.

```ansible-vault decrypt encrypt.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The above command decrypts the file into normal text file. It can be encrypted again either with the same password or a new password. 

You have successfully completed this tutorial. In this Training lab we have learnt how to Create a VCN in Oracle Cloud and create multiple compute instances inside a VCN. We have learnt on how to install Ansible, How Ansible connects with other nodes to execute ansible playbook. 

We have learnt about Asynchrouns actions and polling of tasks, task delegation to a different server, blocks for error handing and encryption of sensitive data. 
