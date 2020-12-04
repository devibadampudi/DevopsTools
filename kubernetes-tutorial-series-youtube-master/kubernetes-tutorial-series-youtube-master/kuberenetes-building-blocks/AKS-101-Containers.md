
# Containers

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Containers](#containers)

[Exercises](#exercises)


## Overview

Containers are packaged software units comprised of code and all of its dependencies, there by allowing it to run smoothly across different environments. Kubernetes is a platform for managing software workloads running in containers.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up containers in Kubernetes. You will start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing containers as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you will learn how to create Containers in a Kuberentes cluster of different OS, with different applications, and understand the similarities and differences between a container and a virtual machine (VM).


## Pre-Requisites

1. Azure Cloud Infrastructure account credentials (User, Password, ResourceGroup, and Subscription).
2. Basic Linux Commands.
3. Docker Fundamentals.
4. Basic Azure Cloud Knowledge.

## Accessing the AKS cluster

**Sign in to Azure portal**

1.	Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

* **Azure Login ID :** {{azure_login}}

* **Azure Password :** {{azure_password}}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage1.png?st=2020-07-08T07%3A23%3A06Z&se=2025-07-09T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jyCYE309j%2B4CNRo8KCcw6n4iP52L97M7lHSj4aAkmvU%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage2.png?st=2020-07-08T07%3A23%3A42Z&se=2025-07-09T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YbUJrHqetC4tgFCqttp1E0iMy5iwIZ1CtOpCoqKxx6o%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage3.png?st=2020-07-08T07%3A24%3A19Z&se=2025-07-09T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h1qLT2oGKl06UclTL1b8TdIdRi9yTXNUu3ck%2BcqDHus%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage4.png?st=2020-07-08T07%3A24%3A54Z&se=2025-07-09T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fNloJnlOJLwLOAvaibTuppCZ862VTo2K9KoOfd6uL4M%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select PowerShell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the PowerShell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the environment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

```bash
kubectl get nodes
```
**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10

```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using this command you get the default namespaces `kubectl get ns`

```bash
kubectl get ns
```
**Output:**
```
NAME          STATUS    AGE
default       Active    8m
kube-public   Active    8m
kube-system   Active    8m
```

## Containers

**A container is like a virtual machine, it can be started using an image**

1. The following command starts with a ubuntu container and gives a user access to shell

```bash
kubectl run ubuntu --rm -it  --image=ubuntu /bin/sh
```

**ubuntu:** This ends up being the name of the Deployment that is created. Your pod name will typically be this plus a unique hash or ID at the end.

**--rm:** Delete any resources we have created once we detach. When you exit out of your session, this cleans up the Deployment and Pod.

**-it:** Pod can run as interactive session.

**bin/sh:** we want to launch bash as our container's command.

**Output:**
```
If you don't see a command prompt, try pressing `enter`.
```

* In the prompt run the following command which will give you the kernel running on the host.

```bash
uname -a
```

**Output:**
```
Linux ubuntu-7d796864c8-qlv5p 4.15.0-1066-azure #71-Ubuntu SMP Thu Dec 12 20:35:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```

* To know the version of Ubuntu you are running, use the `cat /etc/*release` command to display the contents of the file.

```bash
cat /etc/*release
```

* The output will look something like below as shown.

**Output:**
```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.4 LTS"
NAME="Ubuntu"
VERSION="18.04.4 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.4 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic

```
* Type **exit** to exit out of the container, stop and remove it.

* Try it again to see how fast the container starts as compared to a vm.

### A container is not like a vm, it can be started instantaneously 

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/docker-containers.png?st=2019-11-26T12%3A51%3A32Z&se=2021-11-27T12%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NQQbK1ak%2FVp5g4nOl73NKQL6CgQyuedDqcpF%2F9QrvEo%3D" alt="image-alt-text" >

Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems.

2. Choose a different os version image, as in the previous step we have used the image name as just ubuntu.

* If there is no tag after the image name then the default tag(version) is (:)latest, in the following command the tag is (:)16.04, usually it is better to tag the image or specify a particular tag.

**E.g:** imagename:imagetag (ubuntu:16.04)

* Run the following command using the image version 16.04 of ubuntu

```bash
kubectl run ubuntu16 --rm -ti  --image=ubuntu:16.04 /bin/sh
```

**Output:**
```
If you don't see a command prompt, try pressing enter
```

* In the prompt run the following command which will gives you the kernel running on the host

```bash
 uname -a
```

**Output:**
```
Linux ubuntu16-8994779d9-lxxzx 4.15.0-1066-azure #71-Ubuntu SMP Thu Dec 12 20:35:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```

* To know the version of Ubuntu you are running, use the `cat /etc/*release` command to display the contents of the file.

```bash
 cat /etc/*release
```

**Output:**
```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.6 LTS"
NAME="Ubuntu"
VERSION="16.04.6 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.6 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

* Type `exit` to get out of the container

**A container image can be changed very easily, and the the OS version can also be changed very easily**

3. What if we did not want ubuntu, we want alpine Linux, Then run the following command to deploy a alpine container.

```bash
kubectl run alpine --rm -ti  --image=alpine:3.10 /bin/sh
```

* If you don't see a command prompt, try pressing enter, you will be into a shell.

* In the prompt run the following command which will gives you the kernel running on the host

```bash
 uname -a
```

**Output:**
```
Linux alpine-6897b559d8-qhdxb 4.15.0-1066-azure #71-Ubuntu SMP Thu Dec 12 20:35:32 UTC 2019 x86_64 Linux
```
* To know the version of Ubuntu you are running, use the `cat /etc/*release` command to display the contents of the file.

```bash
 cat /etc/*release
```

**Output:**
```
3.10.4
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.10.4
PRETTY_NAME="Alpine Linux v3.10"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://bugs.alpinelinux.org/"
```

* Type `exit` to exit out of the container

**A container image OS can also be changed very easily**

* Notice that we are running a different os now alpine Linux, most Linux distros have images on docker hub. Windows images are also possible but requires the underlying vms to be windows also and are beyond our scope.

* What can developers do with just the os, other software needs to be installed on top of it for their code to work.

**Container images come preinstalled with the required software and their dependencies.**

4. A java developer wants java platform for the we can use OpenJDK image.

* Run the following command, to create and run the container that has a OpenJDK image

```bash
kubectl run openjdk --rm -ti  --image=openjdk /bin/sh
```

* This may take a while as the image is larger in size, run the following command this will show up a kernel version of jdk image.

```bash
uname -a
```

**Output:**
```
Linux openjdk-6bc9576458-cs7z4 4.15.0-1066-azure #71-Ubuntu SMP Thu Dec 12 20:35:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```
* To know the version of OpenJDK run the following command `cat /etc/*release`

```bash
cat /etc/*release
```

**Output:**
```
Oracle Linux Server release 7.7
NAME="Oracle Linux Server"
VERSION="7.7"
ID="ol"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.7"
PRETTY_NAME="Oracle Linux Server 7.7"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:oracle:linux:7:7:server"
HOME_URL="https://linux.oracle.com/"
BUG_REPORT_URL="https://bugzilla.oracle.com/"

ORACLE_BUGZILLA_PRODUCT="Oracle Linux 7"
ORACLE_BUGZILLA_PRODUCT_VERSION=7.7
ORACLE_SUPPORT_PRODUCT="Oracle Linux"
ORACLE_SUPPORT_PRODUCT_VERSION=7.7
Red Hat Enterprise Linux Server release 7.7 (Maipo)
Oracle Linux Server release 7.7
```

* Run the following command to get the java version 

```bash
java -version
```
**Output:**
```
openjdk version "13.0.2" 2020-01-14
OpenJDK Runtime Environment (build 13.0.2+8)
OpenJDK 64-Bit Server VM (build 13.0.2+8, mixed mode, sharing)
```

* Note the OpenJDK image has java 12.0.1 java version and running on oracle linux.

* Type `exit` to exit out of the container

5. What if you are a NodeJS developer?

* Run the following command to deploy a NodeJS container.

```bash
kubectl run node --rm -ti  --image=node:carbon /bin/sh
```

* Run the following command this will show up a kernel version of jdk image.

```bash
uname -a
```

**Output:**
```
Linux node-6d47fc746b-fgsb2 4.15.0-1066-azure #71-Ubuntu SMP Thu Dec 12 20:35:32 UTC 2019 x86_64 GNU/Linux
```
* To know the version of container image you are running, use the `cat /etc/*release` command to display the contents of the file.

```bash
cat /etc/*release
```

**Output:**
```
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
VERSION_CODENAME=stretch
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```
* Run the following command inside a container to check node version.

```bash
 node -v
```

**Output:**
```
v8.17.0
```

* Run the following command inside a container, to check npm version.

```bash
npm -v
```

**Output:**
```
6.13.4
```

* Notice that the node version is `8.16` and npm comes installed with node:carbon image.

* Type `exit` to get out of the container.

**Containers contain everything needed to run particular code, a wide variety of images are available at docker hub.**

* For example information about node image is available here [node](https://hub.docker.com/_/node)

[Dockerhub](https://hub.docker.com/) is the url where you can search for other images. You can also create an account using [docker-signup](https://hub.docker.com/signup) and login to use their public container registry to store your images and make them public if needed. Private images can be pulled from this registry by using the credentials supplied by dockerhub at sign-in.

* Record your username and password of dockerhub registry, this will be used in further sections.

* For a complete list of customizations possible using docker commands, see this url [docker-commands](https://docs.docker.com/engine/reference/builder/)

* If you run a Docker container that has itself Docker installed, then run Docker inside that Docker container (for example, to pull and build images, or to run other containers)

* Save the following configuration code in a notepad with a file called `dond.yml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: dond
  labels:
    app: dond
spec:
  containers:
  - name: dond
    image: docker:latest
    command: ["sleep"]
    args: ["30d"]
    volumeMounts:
    - name: docker
      mountPath: /var/run/docker.sock
    ports:
    - containerPort: 2375
    securityContext:
      privileged: true
  volumes:
  - name: docker
    hostPath: 
      path: /var/run/docker.sock
      type: File
```

* Deploy the configuration code yaml using the following command in PowerShell.

```bash
kubectl create -f dond.yml
```

**Output:**
```
pod/dond created
```

* Get the pods using the following command in PowerShell.

```bash
kubectl get po
```

**Output:**
```
NAME                READY   STATUS             RESTARTS   AGE
dond                1/1     Running            0          31s
```

7. Get a shell into the container running in the dond pod, run the following command in PowerShell.

```bash
kubectl exec -it dond sh
```

* Run `docker version` command to see the version of docker installed.

**Output:**
```
Client: Docker Engine - Community
 Version:           19.03.5
 API version:       1.40
 Go version:        go1.12.12
 Git commit:        633a0ea838
 Built:             Wed Nov 13 07:22:05 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.5
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.12
  Git commit:       633a0ea
  Built:            Wed Nov 13 07:29:19 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.2.10
  GitCommit:        b34a5c8af56e510852c35414db4c1f4fa6172339
 runc:
  Version:          1.0.0-rc8+dev
  GitCommit:        3e425f80a8c931f88e6d94a8c831b9d5aa481657
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

* Change to the directory to /usr using `cd` command

```bash
cd /usr
```
* Create a Dockerfile using `vi Dockerfile` command, save the following Docker configuration code, after you have copied press `Esc` and type `:wq` to save the file and exit.

```
FROM ubuntu 
RUN apt-get update && apt-get install -y telnet
```
* Build the docker image by running the command `.` indicates current directory, where dockerfile should be available. 

* Following configuration enables the network mode for the container

```bash
docker build --network=host -t ubuntu:wtelnet .
```

* You should see an output shown below

**Output:**
```
Sending build context to Docker daemon  165.8MB
Step 1/2 : FROM ubuntu
 ---> 4c108a37151f
Step 2/2 : RUN apt-get update && apt-get install -y telnet
 ---> Running in c0814339c962
Get:1 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:3 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
Get:4 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
Get:5 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]
Get:6 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB]
Get:7 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]
Get:8 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]
Get:9 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [10.8 kB]
Get:10 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [7239 B]
Get:11 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [1239 kB]
Get:12 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [885 kB]
Get:13 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [3927 B]
Get:14 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [2496 B]
Get:15 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [4169 B]
Get:16 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [5436 B]
Get:17 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [721 kB]
Get:18 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [577 kB]
Fetched 16.8 MB in 2s (7759 kB/s)
Reading package lists...
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  netbase
The following NEW packages will be installed:
  netbase telnet
0 upgraded, 2 newly installed, 0 to remove and 8 not upgraded.
Need to get 79.8 kB of archives.
After this operation, 210 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu bionic/main amd64 netbase all 5.4 [12.7 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic/main amd64 telnet amd64 0.17-41 [67.1 kB]
debconf: delaying package configuration, since apt-utils is not installed
Fetched 79.8 kB in 0s (183 kB/s)
Selecting previously unselected package netbase.
(Reading database ... 4040 files and directories currently installed.)
Preparing to unpack .../archives/netbase_5.4_all.deb ...
Unpacking netbase (5.4) ...
Selecting previously unselected package telnet.
Preparing to unpack .../telnet_0.17-41_amd64.deb ...
Unpacking telnet (0.17-41) ...
Setting up netbase (5.4) ...
Setting up telnet (0.17-41) ...
update-alternatives: using /usr/bin/telnet.netkit to provide /usr/bin/telnet (telnet) in auto mode
update-alternatives: warning: skip creation of /usr/share/man/man1/telnet.1.gz because associated file /usr/share/man/man1/telnet.netkit.1.gz (of link group telnet) doesn't exist
Removing intermediate container c0814339c962
 ---> 69a21530a195
Successfully built 69a21530a195
Successfully tagged ubuntu:wtelnet
```

* Now run with the image we built earlier, `ubuntu:wtelnet` using the following command

```bash
docker run -it ubuntu:wtelnet sh
```

* Verify if telnet exists by running

```bash
telnet
```
**Output:**
```
/ # 
# telnet
telnet>
```
* (A telnet session should open, type `quit` to exit the session)

* Type `exit` to exit the myubuntu container
* Type `exit` to exit the dond container

**Output:**
```
telnet> quit
# exit
/ # exit
```

**Containers can contain containers**

* Now that we have built an image with telnet installed, it is possible to create an image with any combinations of packages that can exist on a vm.

**Container images can be customized by installing new software** 

* Get a shell into the container running in the dond pod, and run the following commands inside the pod, change `myregistryusername` to yours credentials.

```bash
kubectl exec -it dond sh
```

* Explicitly tagging an image to registry like Dockerhub through the `tag` command.

E.g. docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

```bash
docker tag ubuntu:wtelnet myregistryusername/ubuntu:wltelnet
```
* Run the following command to login to a Docker registry, Provide Username and Password to login to Dockerhub

```bash
docker login 
```
Login with **your** Docker ID to push and pull images from Docker Hub.

**Output:**
```
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: 
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```
* Push your image to the repository as you created in previous step, run the following command in PowerShell.

```bash
docker push myregistryusername/ubuntu:wltelnet
```

* Pull an image from Docker Hub repository using the following command

```bash
docker pull myregistryusername/ubuntu:wltelnet
```
* To see which images are present locally, use the `docker images` command. This command will show you list of repositories, tag and image id etc.

```bash
docker images
```

**Output:**
```
REPOSITORY   TAG      IMAGE ID        CREATED      SIZE
ubuntu       latest   f50f9524312d    5 days ago   125.1 MB
```

**Containers can be started from images which can be customized using Dockerfile and stored in repositories called container registries**

## Exercises

### Create a ubuntu container and run shell in to it.

<details><summary>show</summary>
<p>

```bash
kubectl run ubuntu --rm -it  --image=ubuntu /bin/sh
```

</p>
</details>

### Check the kernel version of the container image

<details><summary>show</summary>
<p>
  
```bash
uname -a
```

</p>
</details>

### Create a container image with a tag specified

<details><summary>show</summary>
<p>

```bash
kubectl run ubuntu16 --rm -it  --image=ubuntu:16.04 /bin/sh
```

</p>
</details>

Now we are ready to dive into Kubernetes Objects.

**Conclusion:** Congratulations! You have successfully completed the Kubernetes Containers lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
