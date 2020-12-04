# Jobs & Daemonset  

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Job](#Job)

[Daemonset](#daemonset)

[Exercises](#exercises)

## Overview


The main function of a **Job** on Kubernetes is to create one or more pod and tracks about the success of pods. They ensure that the specified number of pods are completed successfully. When a specified number of successful run of pods is completed, then the job is considered complete.

A **Daemonset** ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up Jobs and DaemonSets. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing jobs and DaemonSets as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

At the end of this lab, you'll learn how to create, update, describe, edit, delete a few Kubernetes objects like  Job and Daemonsets.

## Pre-Requisites

1. Azure Cloud Infrastructure account credentials (User, Password, ResourceGroup, and Subscription).
2. Basic Linux Commands.
3. Docker Fundamentals.
4. Basic Azure Cloud Knowledge.

## Accessing the AKS cluster

**Sign in to Azure portal**

1. Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

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

5. Using this command you get the default namespaces in Kubernetes cluster`kubectl get ns`

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
## Job 

Job is a type of kubernetes object which runs a task or a job/script inside one or more pods and ensures that a specified number of them successfully terminate. As pods finish a task described in it successfully, the Job object tracks the completion and terminates the pod. When a job is deleted, it will also clean up the the pods which are created by it. One can also use Job to run multiple pods in parallel which runs for the duration of the task completion.

### Create the Job resource

1. To create a Job one must describe a Job in a YAML file. For example, one can find a sample Job code below which you can use to deploy a Job in one's cluster.

``` yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: job-sample
spec:
  template:
    spec:
      containers: 
        - image:  ashorg/sample:jobsleep
          name: job-sample
      restartPolicy: Never
  backoffLimit: 4
```

### Required Fields

2. Jobs can be described using YAML files, some of the required fields in the Job YAML file are **apiVersion**, **kind**, **metadata**. A Job also requires a **.spec** section. Under the **.spec**  the required fields are **.spec.template** and **.spec.selector**


* Create a yaml file using the code shown above, and use the command in Powershell, below to create a Job.

```bash
kubectl create ns devteam
```

**Output:**
```
devteam/namespace created
```

* Deploy the yaml file configuration code, using the following command in Powershell

```bash
kubectl -n devteam apply -f /c/Users/PhotonUser/Desktop/job.yaml
```

**Output:**
```
job.batch "job-sample" created
```

### Get the Job resource

3. To view the created job use the following command in Powershell.

```bash
kubectl -n devteam get jobs
```

**Output:**
```
NAME         COMPLETIONS   DURATION   AGE
job-sample   1/1           33s        55s
```

### Describe the Job resource

4. One can also describe a Job using the following command in Powershell.

```bash
kubectl -n devteam describe job job-sample
```

**Output:**
```
Name:           job-sample
Namespace:      devteam
Selector:       controller-uid=3bfb909e-d71c-11e9-be70-0a580aed1e95
Labels:         controller-uid=3bfb909e-d71c-11e9-be70-0a580aed1e95
                job-name=job-sample
Annotations:    <none>
Parallelism:    1
Completions:    1
Start Time:     Sat, 14 Sep 2019 18:19:47 +0000
Completed At:   Sat, 14 Sep 2019 18:20:20 +0000
Duration:       33s
Pods Statuses:  0 Running / 1 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=3bfb909e-d71c-11e9-be70-0a580aed1e95
           job-name=job-sample
  Containers:
   job-sample:
    Image:        ashorg/sample:jobsleep
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  95s   job-controller  Created pod: job-sample-dfrzc
```

### Get the Pods created by the Job

5. To view the list of pods created by job use the following command in Powershell.

```bash
kubectl -n devteam get pods -o wide
```

**Output:**
```
NAME               READY     STATUS    RESTARTS   AGE       IP            NODE
job-sample-mzhbt   1/1       Running   0          3s        10.244.2.88   10.0.2.2
```

6. Here one can see that the pods has completed its task and the job is succesffully completed with pod showing the status as **Completed**.

```bash
kubectl -n devteam get pods -o wide
```

**Output:**
```
NAME               READY     STATUS      RESTARTS   AGE       IP            NODE
job-sample-mzhbt   0/1       Completed   0          3m        10.244.2.88   10.0.2.2
```

 Now you have successfully deployed a Job and the pods of that job has completed the task successfully.

### Edit a Job

7. To edit a Job resource in a namespace use the command `kubectl -n devteam edit job <Job-name>`

* The currently deployed job resource YAML will be opened in a text editor and you can edit as per the requirement then save the file, this will update the job resource successfully. Make sure the YAML syntax is followed.


### Delete a Job

8. To delete the Job use the following command in Powershell.

```bash
kubectl -n devteam delete job job-sample
```

**Output:**
```  
  `job.batch "job-sample" deleted`
```

This will successfully delete the pods that got created as part of the Job and the Job resource itself.

## Daemonset

A DaemonSet is a kubernetes object which ensures every node present in the cluster runs a Pod. Whenever new nodes are added to the cluster, a pod is added to that node. As the nodes are removed from the cluster, pods are deleted and garbage collected. Once the DaemonSet is deleted the pods scheduled by it also gets deleted.

**Usecases of DaemonSets**

* One typical usecase would be running a DaemonSet that monitors the nodes such as Prometheus.

### Create a DaemonSet

1. To create a DaemonSet one must describe a DaemonSet in a YAML file. For instance, one can find a sample daemonSet code below  which can be used to deploy a daemonset in a cluster.

``` yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: daemonset-sample
  labels:
    service-name: daemonset-sample
    environment: daemonset-sample
spec:
  selector:
    matchLabels:
      service-name: daemonset-sample
      environment: daemonset-sample
  template:
    metadata:
      labels:
        service-name: daemonset-sample
        environment: daemonset-sample
    spec:
      containers: 
        - image:  ashorg/sample:v1
          name: daemonset-sample
          resources:
          ports:
            - containerPort: 8089
```

### Required Fields

2. DaemonSet can be described using YAML files, some of the required fields in the DaemonSet YAML file are **apiVersion**, **kind**, **metadata**. A DaemonSet also requires a **.spec** section. Under the **.spec**  the required fields are **.spec.template** and **.spec.selector**.

* Create a yaml file using the code shown above, and use the following command in powershell to create a DaemonSet.

```bash
kubectl -n devteam  apply -f /c/Users/PhotonUser/Desktop/job.yaml
```

### Get a DaemonSet resource

3. To view the created Daemonset use the following command in Powershell.

```bash
kubectl -n devteam get ds daemonset-sample
```

**Output:**
```
NAME                DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset-sample    3         3         3         3            3           <none>          1h
```
### Describe a DaemonSet resource

4. One can also describe a DaemonSet using the following command in Powershell

E.g. kubectl -n devteam  describe ds <daemonSet-name>

```
kubectl -n devteam describe ds daemonset-sample
```

**Output:**  
```
Name:           daemonset-sample
Selector:       environment=daemonset-sample,service-name=daemonset-sample
Node-Selector:  <none>
Labels:         environment=daemonset-sample
                service-name=daemonset-sample
Annotations:    <none>
Desired Number of Nodes Scheduled: 3
Current Number of Nodes Scheduled: 3
Number of Nodes Scheduled with Up-to-date Pods: 3
Number of Nodes Scheduled with Available Pods: 3
Number of Nodes Misscheduled: 0
Pods Status:  3 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  environment=daemonset-sample
           service-name=daemonset-sample
  Containers:
   daemonset-sample:
    Image:        ashorg/sample:v1
    Port:         8089/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From                  Message
  ----    ------            ----  ----                  -------
  Normal  SuccessfulCreate  30s   daemonset-controller  Created pod: daemonset-sample-2f95p
  Normal  SuccessfulCreate  30s   daemonset-controller  Created pod: daemonset-sample-88bvt
  Normal  SuccessfulCreate  30s   daemonset-controller  Created pod: daemonset-sample-7blxh
```

### Get the pods created by the DaemonSet
  
5. To view the list of pods created by the DaemonSet use the following command in Powershell.

```bash
kubectl -n devteam get pods -o wide
```

* One must see list of pods as shown below.

**Output:**
```
NAME                     READY     STATUS    RESTARTS   AGE       IP            NODE
daemonset-sample-2f95p   1/1       Running   0          20m       10.244.1.80   10.0.0.2
daemonset-sample-88bvt   1/1       Running   0          20m       10.244.0.61   10.0.1.2
daemonset-sample-7blxh   1/1       Running   0          18m       10.244.2.83   10.0.2.2
```

* Here one can see that the pod has been created in all the node (For this example if it is a 3 node cluster is used.)

6. Now let's delete one of the pods of DaemonSet and observe what happens

```bash
kubectl -n devteam delete pod daemonset-sample-7blxh
```

**Output:**
```
pod "daemonset-sample-7blxh" deleted
```

* Let's list the pods again

```bash
kubectl -n devteam get pods -o wide
```
**Output:**
```
NAME                     READY     STATUS        RESTARTS   AGE       IP            NODE
daemonset-sample-2f95p   1/1       Running       0          1h        10.244.1.80   10.0.0.2
daemonset-sample-88bvt   1/1       Running       0          1h        10.244.0.61   10.0.1.2
daemonset-sample-7blxh   0/1       Terminating   0          1h        10.244.2.83   10.0.2.2
```

* One can see that the pod is started again in the same node with `AGE` as 1m

**Output:**

```
NAME                     READY     STATUS    RESTARTS   AGE       IP            NODE
daemonset-sample-2f95p   1/1       Running   0          1h        10.244.1.80   10.0.0.2
daemonset-sample-88bvt   1/1       Running   0          1h        10.244.0.61   10.0.1.2
daemonset-sample-7blxh   1/1       Running   0          1m        10.244.2.84   10.0.2.2
```

* Now you have successfully deployed a DaemonSet and tested it.

### Edit a DaemonSet

* To edit a DaemonSet resource in a namespace use the command 

**E.g.** `kubectl -n namespace-name edit daemonset DaemonsSet-name`

```bash
kubectl -n devteam edit daemonset daemonset-sample
```

* The currently deployed DaemonSet resource YAML will be opened in a text editor and you can edit as per the requirement then save the file, this will update the DaemonSet resource successfully. Make sure the YAML syntax is followed.

### Delete a DaemonSet

7. To delete the DaemonSet which you have created use the command in Powershell window.

`kubectl -n devteam delete daemonset daemonset-sample`

**Output:**
```
daemonset.extensions "daemonset-sample" deleted
```

Now you have deleted the daemonset successfully.

## Exercises

1. Create the job manually to run the job 4 times in the event of failure

<details><summary>show</summary>
<p>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: job-sample
spec:
  template:
    spec:
      containers: 
        - image:  ashorg/sample:jobsleep
          name: job-sample
      restartPolicy: Never
  backoffLimit: 4
```
</p>
</details>

2. Inspect the details about the job

<details><summary>show</summary>
<p>

```bash
kubectl describe jobs/job-sample
```
</p>
</details>

3. Edit a job resource to add more details

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam edit job job-sample
```
</p>
</details>

4. create a job, make it run 5 parallel times

<details><summary>show</summary>
<p>

``` yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: job-sample
spec:
parallelism: 5 # add this line
  template:
    spec:
      containers: 
        - image:  ashorg/sample:jobsleep
          name: job-sample
      restartPolicy: Never
 ```
</p>
</details>

5. Create a deamonset using the yaml template file

<details><summary>show</summary>
<p>

``` yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: daemonset-sample
  labels:
    service-name: daemonset-sample
    environment: daemonset-sample
spec:
  selector:
    matchLabels:
      service-name: daemonset-sample
      environment: daemonset-sample
  template:
    metadata:
      labels:
        service-name: daemonset-sample
        environment: daemonset-sample
    spec:
      containers: 
        - image:  ashorg/sample:v1
          name: daemonset-sample
          resources:
          ports:
            - containerPort: 8089
```

```bash
kubectl create -f daemonset.yaml
```
</p>
</details>

6. Verify the daemonset has been deployed

<details><summary>show</summary>
<p>

```bash
kubectl get ds
```
</p>
</details>


7. Verify each pod runs on every-node 

<details><summary>show</summary>
<p>

```bash
kubectl get pod -o wide
```

</p>
</details>

8. Edit a daemonset

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam edit daemonset daemonset-sample
```
</p>
</details>

9. clean up the daemonset resources

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam delete daemonset daemonset-sample
```
</p>
</details>

 **Conclusion:** Congratulations! You have successfully completed the Job and Daemonset lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
