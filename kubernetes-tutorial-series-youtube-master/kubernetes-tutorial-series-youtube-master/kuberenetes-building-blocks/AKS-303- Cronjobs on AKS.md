## CronJobs on AKS

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[CronJob in Kubernetes](#cronjob-in-kubernetes)

[Exercises](#exercises)


## Overview

This lab illustrates **Cron Job** features on Azure Kubernetes Service(AKS).

**CronJobs** run tasks at a specific time or interval. CronJobs are a good choice for automatic tasks, such as backups, reporting, sending emails, or cleanup tasks.

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

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the enviornment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

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

## CronJob in Kubernetes

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

Now you should see that the cron job `minute` successfully scheduled a job at the time specified in LAST SCHEDULE is `40s`, Active shows that currently running jobs.

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
kubectl describe jobs
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
