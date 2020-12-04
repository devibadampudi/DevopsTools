# Implement Azure Kubernetes Service

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Provision the lab environment](#provision-the-lab-environment)

[Deploy an Azure Kubernetes Service cluster](#deploy-an-azure-kubernetes-service-cluster)

[Deploy pods into the Azure Kubernetes Service cluster](#deploy-pods-into-the-azure-kubernetes-service-cluster)

[Scale containerized workloads in the Azure Kubernetes service cluster](#scale-containerized-workloads-in-the-azure-kubernetes-service-cluster)

[Conclusion](#conclusion)


## Overview

The main aim of this is to Deploy an Azure Kubernetes Cluster in Azure portal. After that deploy the pods into the Azure Kubernetes cluster then scale the containerized workloads.

**Scenario & Objectives**

Contoso has a number of multi-tier applications that are not suitable to run by using Azure Container Instances. In order to determine whether they can be run as containerized workloads, you want to evaluate using Kubernetes as the container orchestrator. To further minimize management overhead, you want to test Azure Kubernetes Service, including its simplified deployment experience and scaling capabilities.

In this lab, you will learn:

1. Deploying an Azure Kubernetes Service cluster

2. Deploying pods into the Azure Kubernetes Service cluster

3. Scaling containerized workloads in the Azure Kubernetes service cluster

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the Azure Console

## Pre-Requisites

* Azure fundamentals

* Basic knowledge of Kubernetes 

## Provision the lab environment

1.  Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID** : {{azure-login-id}}

**Azure login_Password** : {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

## Deploy an Azure Kubernetes Service cluster

In this task, you will deploy an Azure Kubernetes Services cluster by using the Azure portal.

1. In the Azure portal, search for and locate **Kubernetes services** and then, on the **Kubernetes services** blade, click **+ Add**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/1.png?st=2020-11-19T03%3A13%3A22Z&se=2025-11-20T03%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h4JW2hyzP6puP9KaQ6Cidhhqr%2FXcB0LzjKWGFsxtA2Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/2.png?st=2020-11-19T03%3A18%3A25Z&se=2025-11-20T03%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kGhCoUshfvNQvkT3pvXWy3NglxY91NRSx59gm%2FDePhc%3D)

2. On the **Basics** tab of the **Create Kubernetes cluster** blade, specify the following settings (leave others with their default values):

> **Settings**
     
* **Subscription** - the name of the Azure subscription you are using in this lab 
* **Resource group** - {{resource-group-name}} 
* **Kubernetes cluster name** - az104-9c-aks1
* **Region** - East Us
* **Kubernetes version** - accept the default 
* **Node size** - accept the default 
* **Node count** - 1
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/2-2-createkubernetscluster.png?st=2020-11-10T10%3A00%3A46Z&se=2025-11-11T10%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lDEO%2F8xmxv%2FNF56PoVzgGKsvwaldGASa28B%2BpkT8f8k%3D)

3. Click **Next: Node Pools >** and, on the **Node Pools** tab of the **Create Kubernetes cluster** blade, specify the following settings (leave others with their default values):

> **Settings**
    
* **Virtual nodes** - Disabled
* **VM scale sets** - Enabled

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/2-3-next-nodepools.png?st=2020-11-10T10%3A01%3A09Z&se=2025-11-11T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PKDMpXVOaOdrRCOFSFuqYVdT0Flf%2FFR05hocCWuROw4%3D)

4. Click **Next: Authentication >** and, on the **Authentication** tab of the **Create Kubernetes cluster** blade, specify the following settings (leave others with their default values):

> **Settings**
     
* **Service principal** - Click on the **Configure service principal** and select the **Use Existing**
* **Service Principal Cient ID** - {{client-id}}
* **Service Principal Cient Secret** - {{client-secret}}
* **Enable RBAC** - Yes

> **Note**: If you get a error regarding **client secret invalid** then manually type the client secret while creating the Kubernetes cluster.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/3.PNG?st=2020-11-19T03%3A23%3A45Z&se=2025-11-20T03%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uk9ekjZEDDRfAJl06lW7Uc2tkknpt5xhw6JZXXByEmI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/30.png?st=2020-11-19T03%3A34%3A54Z&se=2025-11-20T03%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7NqNfxQGlVXSP7kUP2agnsWTvJuRvpLapZ%2BjRbGWfW8%3D)

5. Click **Next: Networking >** and, on the **Networking** tab of the **Create Kubernetes cluster** blade, specify the following settings (leave others with their default values):
 
 > **Settings**
    
* **Network configuration** -  Kubenet
* **DNS name prefix** - any valid, globally unique DNS host name 
* **Load balancer** - Standard
* **HTTP application routing** - No

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/2-5-networking.png?st=2020-11-10T10%3A01%3A57Z&se=2025-11-11T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gG4rFf%2F2OoFctWoEsionhiCxNtrBPkyU90L%2FrMBHlQ4%3D)

6. Click **Next: Integration >**, on the **Integration** tab of the **Create Kubernetes cluster** blade, set **Container monitoring** to **Disabled**, click **Review + create** and then click **Create**. 

> **Note**: In production scenarios, you would want to enable monitoring. Monitoring is disabled in this case since it is not covered in the lab. 

> **Note**: Wait for the deployment to complete. This should take about 10 minutes.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/2-6-reviewandcreate.png?st=2020-11-10T10%3A02%3A20Z&se=2025-11-11T10%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WwIl%2Bs%2BvF%2FGZyhUnWfC6v63ZcQQBYtcHh7Dy%2FuXLZrY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/5.png?st=2020-11-19T03%3A36%3A00Z&se=2025-11-20T03%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f3tg3t%2BojgXil8g5%2BOp%2FW5C0PAe5bBA2War30fMwDtQ%3D)

## Deploy pods into the Azure Kubernetes Service cluster

In this task, you will deploy a pod into the Azure Kubernetes Service cluster.

1. On the deployment blade, click the **Go to resource** link.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/6.png?st=2020-11-19T03%3A36%3A55Z&se=2025-11-20T03%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ci2UL7ey8mSFVnA41vOF%2FxUfTpp9slRBnFCadj%2B9f2s%3D)

2. On the **az104-9c-aks1** Kubernetes service blade, in the **Settings** section, click **Node pools**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/7.png?st=2020-11-19T03%3A37%3A27Z&se=2025-11-20T03%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CWD9Xx9H63QJmMZgtaFFqmNfFlLdg9OPMg7w%2BupckTU%3D)

3. On the **az104-9c-aks1 - Node pools** blade, verify that the cluster consists of a single pool with one node.

4. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/8.png?st=2020-11-19T03%3A38%3A03Z&se=2025-11-20T03%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Uo4kQIwbzM%2FlOE%2B6LjY8U7Rre0PrNKNdSU966YCiUr8%3D)

5. Switch the **Azure Cloud Shell** to **Bash** (black background).

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/9.png?st=2020-11-19T03%3A40%3A23Z&se=2025-11-20T03%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v%2BJY2JpvZX91BNH0OWYv9jsZrHMoW0Nc%2BgS2ISMGS6Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/10.png?st=2020-11-19T03%3A42%3A12Z&se=2025-11-20T03%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fAM9oDuXBK0abtfUsXdvaCFduI3nWNcJvUF4wtC65y4%3D)

6. From the Cloud Shell pane, run the following to retrieve the credentials to access the AKS cluster:

RESOURCE_GROUP='{{resource-group-name}}'

```
AKS_CLUSTER='az104-9c-aks1'

az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER
``` 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/11.png?st=2020-11-19T03%3A42%3A57Z&se=2025-11-20T03%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dLUqXEnpSASb8BSJI9YHW5s25DUD8w3cPoHt%2BtCMJfY%3D)

7. From the **Cloud Shell** pane, run the following to verify connectivity to the AKS cluster:

```
kubectl get nodes
```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/12.png?st=2020-11-19T03%3A45%3A09Z&se=2025-11-20T03%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C1%2FiFgd8EBnwicNW%2F1GXH%2B%2F92RLF8YwDEkyQBNj5alA%3D)

8. In the **Cloud Shell** pane, review the output and verify that the one node which the cluster consists of at this point is reporting the **Ready** status. 

9. From the **Cloud Shell** pane, run the following to deploy the **nginx** image from the Docker Hub:

```
kubectl create deployment nginx-deployment --image=nginx
```

> **Note**: Make sure to use lower case letters when typing the name of the deployment (nginx-deployment)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/13.png?st=2020-11-19T03%3A45%3A50Z&se=2025-11-20T03%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gfS%2FcxJw%2BXMyeGbLv9mSqTy%2FBzu%2B5qfP9JWCWCKQAJw%3D)

10. From the **Cloud Shell** pane, run the following to verify that a Kubernetes pod has been created:

```
kubectl get pods
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/14.png?st=2020-11-19T03%3A46%3A42Z&se=2025-11-20T03%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5wTIfgGVn5AfIHqnmbSfMPmp6Y7IPZroGmGCCRBDvNU%3D)

11. From the **Cloud Shell** pane, run the following to identify the state of the deployment:

```
kubectl get deployment
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/15.png?st=2020-11-19T03%3A47%3A05Z&se=2025-11-20T03%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EKJL59iv14DBtHvoAwaxgK3OKuFZJy3XyEpdV8QQfgI%3D)

12. From the **Cloud Shell** pane, run the following to make the pod available from Internet:

```
kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer
```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/16.png?st=2020-11-19T03%3A47%3A30Z&se=2025-11-20T03%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2cpTJ%2FgBVEuKZRPo6F1RaIUVStXEixk%2Bf5MiMLeMwQg%3D)

13. From the **Cloud Shell** pane, run the following to identify whether a public IP address has been provisioned:

```
kubectl get service
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/17.png?st=2020-11-19T03%3A47%3A58Z&se=2025-11-20T03%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Fp%2Bju2%2BkDPoWgpqOLz0Oiq0cAwJLYasFCDRhAuKfIvA%3D)

14. Re-run the command until the value in the **EXTERNAL-IP** column for the **nginx-deployment** entry changes from **\<pending\>** to a public IP address. Note the public IP address in the **EXTERNAL-IP** column for **nginx-deployment**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/31.png?st=2020-11-19T03%3A50%3A20Z&se=2025-11-20T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f9XsoJlCMqpZDH%2BVQlYC77PUhBkaIrz%2BZ%2F2emQk%2FZXo%3D)

15. Open a browser window and navigate to the IP address you obtained in the previous step. Verify that the browser page displays the **Welcome to nginx!** message.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/18.png?st=2020-11-19T03%3A48%3A24Z&se=2025-11-20T03%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mxyfDYe3h70Dpysg%2BhWZcsTQxDvAoCWg%2FWDTD3zkmaw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/19.png?st=2020-11-19T03%3A51%3A33Z&se=2025-11-20T03%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0bM%2FPP3sx5HzwBs40yEIwraKpCwTFrLogoqZMSo7hJ0%3D)

## Scale containerized workloads in the Azure Kubernetes service cluster

In this task, you will scale horizontally the number of pods and then number of cluster nodes.

1. From the **Cloud Shell** pane, run the following to scale the deployment by increasing of the number of pods to 2:

```
kubectl scale --replicas=2 deployment/nginx-deployment
```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/20.png?st=2020-11-19T03%3A52%3A07Z&se=2025-11-20T03%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aBrJuTQ4g3A9HXnFQzi47x0yd99Q98Jhj6OvpHuT3yk%3D)

2. From the **Cloud Shell** pane, run the following to verify the outcome of scaling the deployment:

```
kubectl get pods
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/21.png?st=2020-11-19T03%3A52%3A41Z&se=2025-11-20T03%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SRKYQXg9PDFVRoeuo1YcuEE%2F9qQ8rTG0UqS3UkY%2Fbz8%3D)

 > **Note**: Review the output of the command and verify that the number of pods increased to 2.

3. From the **Cloud Shell** pane, run the following to scale out the cluster by increasing the number of nodes to 2:

```
az aks scale --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --node-count 2
```

> **Note**: Wait for the provisioning of the additional node to complete. This might take about 3 minutes. If it fails, rerun the `az aks scale` command.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/22.PNG?st=2020-11-19T03%3A53%3A33Z&se=2025-11-20T03%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=u3nDg4V7hMQR4sdInVjbaKh2XLMt8GA%2BGvS6KSvFXXs%3D)

4. From the **Cloud Shell** pane, run the following to verify the outcome of scaling the cluster:

```
kubectl get nodes
```
> **Note**: Review the output of the command and verify that the number of nodes increased to 2.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/23.png?st=2020-11-19T03%3A54%3A07Z&se=2025-11-20T03%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CdXON5Pld266kmQRKaQLYlkgrgsxTP70dHD%2FwrKap0k%3D)

5. From the **Cloud Shell** pane, run the following to scale the deployment:

```
kubectl scale --replicas=10 deployment/nginx-deployment
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/24.png?st=2020-11-19T03%3A54%3A32Z&se=2025-11-20T03%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kbxfpXy4NqH4m926WQ%2FOVwiRbXuY9BkVWbcWJMPnahA%3D)

6. From the **Cloud Shell** pane, run the following to verify the outcome of scaling the deployment:

```
kubectl get pods
```

> **Note**: Review the output of the command and verify that the number of pods increased to 10.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/25.png?st=2020-11-19T03%3A54%3A59Z&se=2025-11-20T03%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xmh71FxP3tY34kIjHimdhOOa9Oo%2F8rCSmNZwxN%2Frk4Y%3D)

7. From the **Cloud Shell** pane, run the following to review the pods distribution across cluster nodes:

```
kubectl get pod -o=custom-columns=NODE:.spec.nodeName,POD:.metadata.name
```

> **Note**: Review the output of the command and verify that the pods are distributed across both nodes.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/26.PNG?st=2020-11-19T03%3A55%3A54Z&se=2025-11-20T03%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T2FuvnLmBo8RUVtKoIgWK6NwDkpwWCnAFEqXIhKGGyc%3D)

8. From the **Cloud Shell** pane, run the following to delete the deployment:

```
kubectl delete deployment nginx-deployment
```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement_Azure_Kubernetes_Service/Images/27.png?st=2020-11-19T03%3A56%3A23Z&se=2025-11-20T03%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XLuvl8kDiheoTfCkhpinpsYxROxapXLYOFVuS7D2RvM%3D)

9. Close the **Cloud Shell** pane.

## Conclusion

Congratulations! You have successfully completed the lab **Implement_Azure_Kubernetes_Service**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
