# CronJob in Kubernetes

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[CronJob](#Cronjob)

[Exercises](#exercises)

## Overview

This lab illustrates **Cron Job** feature on Elastic Kubernetes Service(EKS).

**CronJobs** run tasks at a specific time or interval. CronJobs are a good choice for automatic tasks, such as backups, reporting, sending emails, or cleanup tasks.

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up CronJobs. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing CronJobs as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

At the end of this lab, you'll learn how to create, update, describe, edit, delete a few Kubernetes Objects like Cronjob.

## Pre-Requisites

None required

## Accessing the EKS cluster

### Sign in to AWS Management console

* Navigate to **Chrome** on the right pane, you should see AWS console page.

* Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Use below credentials to login to AWS console.

* **Account ID:** `{{Account_ID}}` <br>
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

* Select **IAM user** and then enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

*  Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/3.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/4.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/5.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Click Apps icon in the toolbar and select **Powershell** to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-23T06%3A16%3A39Z&se=2022-10-24T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Gg0Ouxr68ThRowxFznGsXgXiaWWNOTj7kM7gXm34dGs%3D" alt="image-alt-text">

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Cluster-region}}

* **Output-format:** json

* Need to configure the AWS credentials for accessing the cluster run the command `aws configure` then enter the  specified credentials as you get in previous step.

`aws configure`

**Output:**

```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json

```
* **Cluster-region:** {{Cluster-region}}

* **Cluster-name:** {{Cluster-name}}

* Run the following command to generate kubeconfig file for cluster.

```bash
aws eks --region {{Cluster-region}} update-kubeconfig --name {{Cluster-name}}

```

* We have initialized the enviornment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`kubectl get nodes`

**Output:**

```
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```
## CronJob

CronJobs are just like cron on linux, they can run at any specified time intervals and also take the schedule just like on linux in the following format

* CronJob to run Jobs based on time-based schedule

```
* * * * * 
- - - - -
| | | | |
| | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
| | | ------- Month (1 - 12)
| | --------- Day of month (1 - 31)
| ----------- Hour (0 - 23)
------------- Minute (0 - 59)
```
* Deploy the following yaml configuration file to create a cronjob with specified requirements. Save the following manifest in a file `cronjob.yaml` & save it

``` yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: minute
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: ubuntu
            args:
            - /bin/bash
            - -c
            - date; echo cronjob minute says hi; sleep 30d
          restartPolicy: OnFailure
```
* Deploy the `cronjob.yaml` using the following command.

```bash
kubectl create -f cronjob.yaml
```

* Above manifest file creates cronjob, to get these jobs, run the following command to get cronjob you created.

```bash
kubectl get cronjob
```
**Output:**
```
NAME     SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
minute   */1 * * * *   False     10       40s             9m49s
```

* Now you should see that the cron job `minute` successfully scheduled a job at the time specified in LAST SCHEDULE is `40s`, Active shows that currently running jobs.

* The cron job has not scheduled or run any jobs yet. Watch for the job to be created in around one minute

```bash
kubectl get jobs
```
**Output:**
```
NAME                COMPLETIONS   DURATION   AGE
minute-1578378000   0/1           2m17s      2m17s
minute-1578378060   0/1           76s        76s
minute-1578378120   0/1           16s        16s
```

* To get the pods for the job , run the following command in `gitbash` terminal

**Note:** Replace job-name with yours

```bash
pods=$(kubectl get pods --selector=job-name=minute-1578378000 --output=jsonpath={.items[].metadata.name})
```

* To get the logs of pod run the following command

```bash
kubectl logs $pods
``` 
**Output:**
```
Tue Jan  7 06:20:07 UTC 2020
cronjob minute says hi
cronjob minute says hi
```
* Describe the job resource to get more information about jobs 

```bash
kubectl describe jobs minute-1578378000
```
**Output:**
```
Name:           minute-1578378000
Namespace:      default
Selector:       controller-uid=bd64f5a9-3115-11ea-adcd-122a7aa37019
Labels:         controller-uid=bd64f5a9-3115-11ea-adcd-122a7aa37019
                job-name=minute-1578378000
Annotations:    <none>
Controlled By:  CronJob/minute
Parallelism:    1
Completions:    1
Start Time:     Tue, 07 Jan 2020 06:20:02 +0000
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=bd64f5a9-3115-11ea-adcd-122a7aa37019
           job-name=minute-1578378000
  Containers:
   hello:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/bash
      -c
      date; echo cronjob minute says hi; sleep 30d
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  4m8s  job-controller  Created pod: minute-1578378000-m82xq
Name:           minute-1578378060
Namespace:      default
Selector:       controller-uid=e13f77cf-3115-11ea-adcd-122a7aa37019
Labels:         controller-uid=e13f77cf-3115-11ea-adcd-122a7aa37019
                job-name=minute-1578378060
Annotations:    <none>
Controlled By:  CronJob/minute
Parallelism:    1
Completions:    1
Start Time:     Tue, 07 Jan 2020 06:21:03 +0000
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=e13f77cf-3115-11ea-adcd-122a7aa37019
           job-name=minute-1578378060
  Containers:
   hello:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/bash
      -c
      date; echo cronjob minute says hi; sleep 30d
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  3m8s  job-controller  Created pod: minute-1578378060-vldgd
Name:           minute-1578378120
Namespace:      default
Selector:       controller-uid=0516472c-3116-11ea-adcd-122a7aa37019
Labels:         controller-uid=0516472c-3116-11ea-adcd-122a7aa37019
                job-name=minute-1578378120
Annotations:    <none>
Controlled By:  CronJob/minute
Parallelism:    1
Completions:    1
Start Time:     Tue, 07 Jan 2020 06:22:03 +0000
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=0516472c-3116-11ea-adcd-122a7aa37019
           job-name=minute-1578378120
  Containers:
   hello:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/bash
      -c
      date; echo cronjob minute says hi; sleep 30d
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  2m8s  job-controller  Created pod: minute-1578378120-qc69j

Name:           minute-1578378180
Namespace:      default
Selector:       controller-uid=28ec0ecf-3116-11ea-adcd-122a7aa37019
Labels:         controller-uid=28ec0ecf-3116-11ea-adcd-122a7aa37019
                job-name=minute-1578378180
Annotations:    <none>
Controlled By:  CronJob/minute
Parallelism:    1
Completions:    1
Start Time:     Tue, 07 Jan 2020 06:23:03 +0000
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=28ec0ecf-3116-11ea-adcd-122a7aa37019
           job-name=minute-1578378180
  Containers:
   hello:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/bash
      -c
      date; echo cronjob minute says hi; sleep 30d
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  69s   job-controller  Created pod: minute-1578378180-9wxr8

 


Name:           minute-1578378240
Namespace:      default
Selector:       controller-uid=4cc209eb-3116-11ea-adcd-122a7aa37019
Labels:         controller-uid=4cc209eb-3116-11ea-adcd-122a7aa37019
                job-name=minute-1578378240
Annotations:    <none>
Controlled By:  CronJob/minute
Parallelism:    1
Completions:    1
Start Time:     Tue, 07 Jan 2020 06:24:03 +0000
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=4cc209eb-3116-11ea-adcd-122a7aa37019
           job-name=minute-1578378240
  Containers:
   hello:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/bash
      -c
      date; echo cronjob minute says hi; sleep 30d
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  9s    job-controller  Created pod: minute-1578378240-42dgq
```

* To clean up the cronjob resource, use the following command to delete it.

```bash
kubectl delete cronjob minute
```
**Output:**
```
cronjob.batch "minute" deleted
```

## Exercises

1. Create a cron job with ubuntu image that runs on a schedule of "*/1 * * * *" and writes 'date; echo Hello from the Kubernetes cluster' to standard output.

<details><summary>show</summary>
<p>

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: minute
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: ubuntu
            args:
            - /bin/bash
            - -c
            - date; echo Hello from the Kubernetes cluster; sleep 30d
          restartPolicy: OnFailure
```
</p>
</details>

2. List out the jobs that has been created

<details><summary>show</summary>
<p>

```bash
kubectl get jobs
```

</p>
</details>

3. Get the pods for the job

<details><summary>show</summary>
<p>

```bash
pods=$(kubectl get pods --selector=job-name=minute-1562068560 --output=jsonpath={.items[].metadata.name})
```
</p>
</details>

4. Check the logs and delete job

<details><summary>show</summary>
<p>

```bash
kubectl logs $pods
kubectl delete cj minute

```
</p>
</details>

**Conclusion:** Congratulations! You have successfully completed the CronJob lab! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
