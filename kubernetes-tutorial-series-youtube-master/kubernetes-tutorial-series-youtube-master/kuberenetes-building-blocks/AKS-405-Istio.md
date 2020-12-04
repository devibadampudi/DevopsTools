# Intelligent Routing and Canary Releases using Istio in Azure Kubernetes Service(AKS)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Intelligent Routing and Canary Releases](#intelligent-routing-and-canary-releases)

## Overview

This lab demonstrates how to use the traffic management functionality of Istio, a completely open source service mesh that layers transparently onto existing distributed applications. 

Istio provides a key set of functionality across the microservices in a Kubernetes cluster. These features include traffic management, service identity and security, policy enforcement, and observability.

A sample voting application will be used to explore **Intelligent Routing and Canary Releases**.


## Pre-Requisites

* Knowledge of Helm is required

## Accessing the AKS cluster

**Sign in to Azure portal**

1. Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

* **Azure Login ID :** {{azure_login}}

* **Azure Password :** {{azure_password}}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/landingpage.PNG?st=2019-10-16T09%3A58%3A17Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CUJ%2B2tK4s25F%2BL88voMTtzpAM8obbAYafLnFYsuYOzc%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like `MC_myResourceGroup_myAKSCluster_eastus` AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.


```bash
az login -u '{{azure_login}}' -p '{{azure_password}}'
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the environment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a k8's cluster.

```bash
kubectl get nodes
```

```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentpool-13196272-0   Ready    agent   7m8s    v1.13.11
aks-agentpool-13196272-1   Ready    agent   7m15s   v1.13.11
aks-agentpool-13196272-2   Ready    agent   7m12s   v1.13.11
```

5. Use the following command, you get the default namespaces in Kubernetes cluster.

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

## Intelligent Routing and Canary Releases

### Add Istio Helm chart repository & Installation of Tiller

The Helm Client is a command-line client for end users. The client is responsible for the following domains:

  * Local chart development
  * Managing repositories
  * Interacting with the Tiller server
    * Sending charts to be installed
    * Asking for information about releases
    * Requesting upgrading or uninstalling of existing releases
    
 **Tiller Server** is an in-cluster server that interacts with the Helm client, and interfaces with the Kubernetes API server. The server is responsible for the following:

  * Listening for incoming requests from the Helm client
  * Combining a chart and configuration to build a release
  * Installing charts into Kubernetes, and then tracking the subsequent release
  * Upgrading and uninstalling charts by interacting with Kubernetes

Add the Istio Helm chart repository for the Istio release. Ensure that you run the helm repo update to update your local information for the chart repository, enter the following commands in Windows PowerShell that was used in previous section.

```Powershell
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.3.2/charts/
helm repo update
```

* Install `Tiller` on the kubernetes cluster.

```
helm init
```
### Install Istio CRDs on AKS

Istio uses Custom Resource Definitions (CRDs) to manage its runtime configuration. We need to install the Istio CRDs first, since the Istio components have a dependency on them. Use Helm and the `istio-init` chart to install the Istio CRDs into the `istio-system` namespace in your AKS cluster.

* Use the following command in PowerShell to install the `istio.io` helm chart.

```
helm install istio.io/istio-init --name istio-init --namespace istio-system
```

* Jobs are deployed as part of the istio-init Helm Chart to install the CRDs. These jobs should take less than 20s to complete, depending on your cluster environment. You can verify that the jobs have successfully completed as follows.

```
kubectl get jobs -n istio-system
```

* The following output shows successfully completed jobs. Wait till Completions `1/1`

**Output:**
```
NAME                      COMPLETIONS   DURATION   AGE
istio-init-crd-10-1.3.2   1/1           14s        14s
istio-init-crd-11-1.3.2   1/1           12s        14s
istio-init-crd-12-1.3.2   1/1           14s        14s
```

* Now that we have confirmed the successful completion of the jobs, let's verify that we have the correct number of Istio CRDs installed. You can verify that all `23` Istio CRDs have been installed by running the following command. The command should return the number `23`.

```
(kubectl get crds | Select-String -Pattern 'istio.io').Count
```

* Ouptut should displays `23` which means you have successfully installed Istio CRDs.

**Output:**
```
23
```

### Install Istio components on AKS

We will be installing **Grafana** and **Kiali** as part of our Istio installation. Grafana provides analytics and monitoring dashboards, and Kiali provides a service mesh observability dashboard. In our setup, each of these components requires credentials that must be provided as a `Secret`.

* Before we can install the Istio components, we must create the secrets for both Grafana and Kiali.

### Add Grafana Secret

* Below comand converts given `username` to the base64. Run the command using powershell that was used in previous sections.  

```bash
$GRAFANA_USERNAME=[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("grafana"))
```

* Replace  `REPLACE_WITH_YOUR_SECURE_PASSWORD` token with your password and run the following command.

```bash
$GRAFANA_PASSPHRASE=[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("REPLACE_WITH_YOUR_SECURE_PASSWORD"))
```

* Save the following `yaml` configuration code in a file, copy and paste it in notepad with name `grafana-secret.yaml`.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: grafana
  namespace: istio-system
  labels:
    app: grafana
type: Opaque
data:
  username: $GRAFANA_USERNAME
  passphrase: $GRAFANA_PASSPHRASE
```

* Deploy it using the following command in Powershell. It creates a secret with name `grafana`.

```bash
kubectl apply -f grafana-secret.yaml
```

**Output:**
```
secret/grafana created
```

### Add Kiali Secret

* Below command converts given `username` to the base64. Run the command using PowerShell

```bash
$KIALI_USERNAME=[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("kiali"))
```

* Replace  `REPLACE_WITH_YOUR_SECURE_PASSWORD` token with your password and run the following command.

```bash
$KIALI_PASSPHRASE=[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("REPLACE_WITH_YOUR_SECURE_PASSWORD"))
```

* Save the following `yaml` configuration code in a file, copy and paste it in notepad with name `kiali-secret.yaml`.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
type: Opaque
data:
  username: $KIALI_USERNAME
  passphrase: $KIALI_PASSPHRASE
```

* Deploy it using the following command in Powershell. It creates a secret with name `kiali`.

```bash
kubectl apply -f kiali-secret.yaml
```

**Output:**
```
secret/kiali created
```

### Install Istio components

Now that we have successfully created the Grafana and Kiali secrets in our AKS cluster, it is time to install Istio components. Use Helm and the Istio chart to install the Istio components into the `istio-system` namespace in your AKS cluster.

* Use the following command in PowerShell to install the istio chart using `helm install`.

```
helm install istio.io/istio --name istio --namespace istio-system --version "1.3.2" `
  --set global.controlPlaneSecurityEnabled=true `
  --set global.mtls.enabled=true `
  --set grafana.enabled=true --set grafana.security.enabled=true `
  --set tracing.enabled=true `
  --set kiali.enabled=true `
  --set global.defaultNodeSelector."beta\.kubernetes\.io/os"=linux
```

* The Istio Helm chart deploys a large number of objects. You can see the list from the output of your helm install command above. The deployment of the Istio components should take under 2 minutes to complete, depending on your cluster environment.

* At this point, we have deployed Istio to AKS cluster. To ensure that we have a successful deployment of Istio.

### Validate the Istio installation

* First confirm that the expected services have been created.

* Use the `kubectl get svc command` to view the running services. Query the `istio-system` namespace, where the Istio and add-on components were installed by the Istio Helm chart.

```bash
kubectl get svc --namespace istio-system --output wide
```

* If the `istio-ingressgateway` shows an `EXTERNAL-IP` of `<pending>`, wait a few minutes until an IP address has been assigned by Azure networking.

**Output:**
```
NAME                     TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                                                                                                                                      AGE   SELECTOR
grafana                  ClusterIP      10.0.164.244   <none>           3000/TCP                                                                                                                                     53s   app=grafana
istio-citadel            ClusterIP      10.0.49.16     <none>           8060/TCP,15014/TCP                                                                                                                           53s   istio=citadel
istio-galley             ClusterIP      10.0.175.173   <none>           443/TCP,15014/TCP,9901/TCP                                                                                                                   53s   istio=galley
istio-ingressgateway     LoadBalancer   10.0.226.151   52.183.64.224
   15020:31128/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:30817/TCP,15030:30436/TCP,15031:32485/TCP,15032:30980/TCP,15443:30124/TCP   53s   app=istio-ingressgateway,istio=ingressgateway,release=istio
istio-pilot              ClusterIP      10.0.102.158   <none>           15010/TCP,15011/TCP,8080/TCP,15014/TCP                                                                                                       53s   istio=pilot
istio-policy             ClusterIP      10.0.234.53    <none>           9091/TCP,15004/TCP,15014/TCP                                                                                                                 53s   istio-mixer-type=policy,istio=mixer
istio-sidecar-injector   ClusterIP      10.0.216.8     <none>           443/TCP,15014/TCP                                                                                                                            53s   istio=sidecar-injector
istio-telemetry          ClusterIP      10.0.154.215   <none>           9091/TCP,15004/TCP,15014/TCP,42422/TCP                                                                                                       53s   istio-mixer-type=telemetry,istio=mixer
jaeger-agent             ClusterIP      None           <none>           5775/UDP,6831/UDP,6832/UDP                                                                                                                   52s   app=jaeger
jaeger-collector         ClusterIP      10.0.26.109    <none>           14267/TCP,14268/TCP                                                                                                                          52s   app=jaeger
jaeger-query             ClusterIP      10.0.70.55     <none>           16686/TCP                                                                                                                                    52s   app=jaeger
kiali                    ClusterIP      10.0.36.206    <none>           20001/TCP                                                                                                                                    53s   app=kiali
prometheus               ClusterIP      10.0.236.99    <none>           9090/TCP                                                                                                                                     53s   app=prometheus
tracing                  ClusterIP      10.0.83.152    <none>           80/TCP                                                                                                                                       52s   app=jaeger
zipkin                   ClusterIP      10.0.25.86     <none>           9411/TCP                                                                                                                                     52s   app=jaeger
```

* Next, confirm that the required pods have been created.

* Use the `kubectl get pods` command, and again query the `istio-system` namespace.

```bash
kubectl get pods --namespace istio-system
```
**Output:**
```
NAME                                     READY   STATUS      RESTARTS   AGE
grafana-7c48555456-msl7b                 1/1     Running     0          88s
istio-citadel-566fc66db7-m8wgl           1/1     Running     0          87s
istio-galley-5746db8d56-pl5gg            1/1     Running     0          88s
istio-ingressgateway-6c94f7c9bf-f5lt5    1/1     Running     0          88s
istio-init-crd-10-1.3.2-xw9g2            0/1     Completed   0          92m
istio-init-crd-11-1.3.2-54rz8            0/1     Completed   0          92m
istio-init-crd-12-1.3.2-789qj            0/1     Completed   0          92m
istio-pilot-6748968b6d-rvdfx             2/2     Running     0          87s
istio-policy-7576bbbcf7-2stft            2/2     Running     0          87s
istio-sidecar-injector-76d79d494-7jk9n   1/1     Running     0          87s
istio-telemetry-74b7bf676d-tfrcl         2/2     Running     0          88s
istio-tracing-655d9588bc-d2htg           1/1     Running     0          86s
kiali-65d55bcfb8-tqrfk                   1/1     Running     0          88s
prometheus-846f9849bd-br8kp              1/1     Running     0          87s
```

* There should be three `istio-init-crd-*` pods with a Completed status. These pods were responsible for running the jobs that created the CRDs in an earlier step. All of the other pods should show a status of `Running`. If your pods don't have these statuses, wait a minute or two minutes until they do. If any pods report an issue, use below  command to review their output and status.

* Replace the pod name with yours pod name, run the following command using PowerShell that was used in previous section.

**E.g.** kubectl describe pod `<podname>`

```bash
kubectl describe pod istio-policy-7576bbbcf7-2stft
```

**Note:** Make sure that all steps executed successfully to proceed further section.

**About this application scenario**

* The sample AKS voting app provides two voting options (Cats or Dogs) to users. There is a storage component that persists the number of votes for each option. Additionally, there is an analytics component that provides details around the votes cast for each option.

* In this application scenario, you start by deploying version 1.0 of the voting app and version 1.0 of the analytics component. The analytics component provides simple counts for the number of votes. The voting app and analytics component interact with version 1.0 of the storage component, which is backed by Redis.

* You upgrade the analytics component to version 1.1, which provides counts, and now totals and percentages.

* A subset of users test version 2.0 of the app via a canary release. This new version uses a storage component that is backed by a MySQL database.

* Once you are confident that version 2.0 works as expected on your subset of users, you roll out version 2.0 to all your users.

### Deploy the application

Let's start by deploying the application into your Azure Kubernetes Service(AKS) cluster. The following diagram shows what runs by the end of this section - version 1.0 of all components with inbound requests serviced via the Istio ingress gateway.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/istio-app-storage.png?st=2019-11-11T06%3A34%3A19Z&se=2021-11-12T06%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EjOLW9Y7tBEUcaJg9222qOk0jqH8Hzi6wa%2FSMObhKdo%3D" alt="image-alt-text">

* You can download the artifacts or clone the repo using the following command.

```bash
git clone https://github.com/Azure-Samples/aks-voting-app.git
```

**Output:**
```
Cloning into 'aks-voting-app'...
remote: Enumerating objects: 43, done.
remote: Counting objects: 100% (43/43), done.
remote: Compressing objects: 100% (34/34), done.
Receiving objects:  89% (190/213)   38 (delta 7), pack-reused 170 eceiving objects:  88% (188/213)
Receiving objects: 100% (213/213), 53.36 KiB | 354.00 KiB/s, done.
Resolving deltas: 100% (94/94), done.
```

* Change to the following folder in the downloaded/cloned repo and run all subsequent steps from this folder.

```bash
cd scenarios/intelligent-routing-with-istio
```

* Run the `ls` command inside the directory to list out the configuration files/folders.
```
ls
```

**Output:**
```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         8/6/2019   5:32 PM                istio
d-----         8/6/2019   5:32 PM                kubernetes
d-----         8/6/2019   5:32 PM                release
-a----         8/6/2019   5:32 PM           1032 README.md
```
* First, create a namespace in your AKS cluster for the sample AKS voting app named voting as shown below.

```bash
kubectl create ns voting
```

**Output:**
```
namespace "voting" created
```

* Label the namespace with `istio-injection=enabled`. This label instructs Istio to automatically inject the istio-proxies as sidecars into all of your pods in this namespace.

`kubectl label namespace voting istio-injection=enabled`

**Output:**
```
namespace "voting" labeled
```

* Now let's create the components for the AKS Voting app. Create these components in the voting namespace created in a previous step.

```bash
kubectl apply -f kubernetes/step-1-create-voting-app.yaml --namespace voting
```

**Output:**
```
deployment.apps "voting-storage-1-0" created
service "voting-storage" created
deployment.apps "voting-analytics-1-0" created
service "voting-analytics" created
deployment.apps "voting-app-1-0" created
service "voting-app" created
```

* To see the pods that have been created, use the `kubectl get pods` command with `-n voting`.

* The following example output shows there are three instances of the voting-app pod and a single instance of both the voting-analytics and voting-storage pods. Each of the pods has two containers. One of these containers is the component, and the other is the istio-proxy.

```bash
kubectl get pods -n voting
```

**Output:**
```
NAME                                    READY     STATUS    RESTARTS   AGE
voting-analytics-1-0-79fbdb99f9-fbt7r   2/2       Running   0          22s
voting-app-1-0-ffb8c5dbf-9pwqw          2/2       Running   0          20s
voting-app-1-0-ffb8c5dbf-jmxgv          2/2       Running   0          20s
voting-app-1-0-ffb8c5dbf-kxn9f          2/2       Running   0          20s
voting-storage-1-0-cd5b4bf45-tjzgv      2/2       Running   0          23s
```
* To see information about the pod, use the kubectl describe pod. Replace the pod name with the name of a pod in your own AKS cluster from the previous output:

* The `istio-proxy` container has automatically been injected by Istio to manage the network traffic to and from your components, as shown in the following example output.

**Note:** Replace pod name with yours.

* Run the following command to describe the pod to view the pod configuration.

`kubectl describe pod voting-app-1-0-ffb8c5dbf-9pwqw --namespace voting`

**Output:**
```
Name:               voting-app-1-0-ffb8c5dbf-9pwqw
Namespace:          voting
Priority:           0
PriorityClassName:  <none>
Node:               aks-agentpool-20624331-2/10.240.0.66
Start Time:         Tue, 06 Aug 2019 17:38:46 +0530
Labels:             app=voting-app
                    pod-template-hash=ffb8c5dbf
                    version=1.0
Annotations:        sidecar.istio.io/status={"version":"761ebc5a63976754715f22fcf548f05270fb4b8db07324894aebdb31fa81d960","initContainers":["istio-init"],"containers":["istio-proxy"],"volumes":["istio-envoy","istio-certs...
Status:             Running
IP:                 10.240.0.94
Controlled By:      ReplicaSet/voting-app-1-0-ffb8c5dbf
Init Containers:
  istio-init:
    Container ID:  docker://a53c88a78436a6e8b3be0066f9b1ffe741e71a9e6a5481cd110f687dad111e15
    Image:         docker.io/istio/proxy_init:1.2.2
    Image ID:      docker-pullable://istio/proxy_init@sha256:d291e6d584c86ed8a62d0936943082790b71dcb4fcc18dd4a6e2d31ca908b522
    Port:          <none>
    Host Port:     <none>
    Args:
      -p
      15001
      -u
      1337
      -m
      REDIRECT
      -i
      *
      -x

      -b
      8080
      -d
      15020
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 06 Aug 2019 17:38:48 +0530
      Finished:     Tue, 06 Aug 2019 17:38:49 +0530
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  50Mi
    Requests:
      cpu:        10m
      memory:     10Mi
    Environment:  <none>
    Mounts:       <none>
Containers:
  voting-app:
    Container ID:   docker://edfbb358943758c7d11e8042972193c9e8bf6ed52a9c0c2d840ab7ce442ba4af
    Image:          mcr.microsoft.com/aks/samples/voting/app:1.0
    Image ID:       docker-pullable://mcr.microsoft.com/aks/samples/voting/app@sha256:fba1534c827930e2f47e8003c29fafb1c61e56071dbf343b3cd9d5e9d8954941
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 06 Aug 2019 17:38:50 +0530
    Ready:          True
    Restart Count:  0
    Environment:
      SHOWDETAILS:     true
      FEATUREFLAG:     true
      REDIS_HOST:      voting-storage
      ANALYTICS_HOST:  voting-analytics
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-td2ws (ro)
  istio-proxy:
    Container ID:  docker://43da131c60246f3e0312ba1b1501876eb853e5cf6beabe948f8e61842bcd8a1c
    Image:         docker.io/istio/proxyv2:1.2.2
    Image ID:      docker-pullable://istio/proxyv2@sha256:236527816ff67f8492d7286775e09c28e207aee2f6f3c3d9258cd2248af4afa5
    Port:          15090/TCP
    Host Port:     0/TCP
    Args:
      proxy
      sidecar
      --domain
      $(POD_NAMESPACE).svc.cluster.local
      --configPath
      /etc/istio/proxy
      --binaryPath
      /usr/local/bin/envoy
      --serviceCluster
      voting-app.$(POD_NAMESPACE)
      --drainDuration
      45s
      --parentShutdownDuration
      1m0s
      --discoveryAddress
      istio-pilot.istio-system:15011
      --zipkinAddress
      zipkin.istio-system:9411
      --dnsRefreshRate
      300s
      --connectTimeout
      10s
      --proxyAdminPort
      15000
      --concurrency
      2
      --controlPlaneAuthPolicy
      MUTUAL_TLS
      --statusPort
      15020
      --applicationPorts
      8080
    State:          Running
      Started:      Tue, 06 Aug 2019 17:38:51 +0530
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     2
      memory:  1Gi
    Requests:
      cpu:      100m
      memory:   128Mi
    Readiness:  http-get http://:15020/healthz/ready delay=1s timeout=1s period=2s #success=1 #failure=30
    Environment:
      POD_NAME:                          voting-app-1-0-ffb8c5dbf-9pwqw (v1:metadata.name)
      POD_NAMESPACE:                     voting (v1:metadata.namespace)
      INSTANCE_IP:                        (v1:status.podIP)
      ISTIO_META_POD_NAME:               voting-app-1-0-ffb8c5dbf-9pwqw (v1:metadata.name)
      ISTIO_META_CONFIG_NAMESPACE:       voting (v1:metadata.namespace)
      ISTIO_META_INTERCEPTION_MODE:      REDIRECT
      ISTIO_META_INCLUDE_INBOUND_PORTS:  8080
      ISTIO_METAJSON_LABELS:             {"app":"voting-app","pod-template-hash":"ffb8c5dbf","version":"1.0"}

    Mounts:
      /etc/certs/ from istio-certs (ro)
      /etc/istio/proxy from istio-envoy (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-td2ws (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-td2ws:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-td2ws
    Optional:    false
  istio-envoy:
    Type:    EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:  Memory
  istio-certs:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  istio.default
    Optional:    true
QoS Class:       Burstable
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age   From                               Message
  ----     ------     ----  ----                               -------
  Normal   Scheduled  59s   default-scheduler                  Successfully assigned voting/voting-app-1-0-ffb8c5dbf-9pwqw to aks-agentpool-20624331-2
  Normal   Pulled     57s   kubelet, aks-agentpool-20624331-2  Container image "docker.io/istio/proxy_init:1.2.2" already present on machine
  Normal   Created    56s   kubelet, aks-agentpool-20624331-2  Created container
  Normal   Started    56s   kubelet, aks-agentpool-20624331-2  Started container
  Normal   Pulling    54s   kubelet, aks-agentpool-20624331-2  pulling image "mcr.microsoft.com/aks/samples/voting/app:1.0"
  Normal   Pulled     54s   kubelet, aks-agentpool-20624331-2  Successfully pulled image "mcr.microsoft.com/aks/samples/voting/app:1.0"
  Normal   Created    54s   kubelet, aks-agentpool-20624331-2  Created container
  Normal   Started    54s   kubelet, aks-agentpool-20624331-2  Started container
  Normal   Pulled     54s   kubelet, aks-agentpool-20624331-2  Container image "docker.io/istio/proxyv2:1.2.2" already present on machine
  Normal   Created    53s   kubelet, aks-agentpool-20624331-2  Created container
  Normal   Started    53s   kubelet, aks-agentpool-20624331-2  Started container
  Warning  Unhealthy  52s   kubelet, aks-agentpool-20624331-2  Readiness probe failed: HTTP probe failed with statuscode: 503
```

* You can't connect to the voting app until you create the Istio Gateway and Virtual Service. These Istio resources route traffic from the default Istio ingress gateway to our application.

* Use the `kubectl apply` command to deploy the Gateway and Virtual Service yaml. Remember to specify the namespace that these resources are deployed into.

`kubectl apply -f istio/step-1-create-voting-app-gateway.yaml --namespace voting`

**Output:**
```
virtualservice.networking.istio.io "voting-app" created
gateway.networking.istio.io "voting-app-gateway" created
```

* Obtain the IP address of the Istio Ingress Gateway using the following command

`kubectl get service istio-ingressgateway --namespace istio-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`

**Output:**
```
52.183.64.224
```

* Open up a browser and paste in the IP address. The sample AKS voting app is displayed.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v1.png?st=2019-11-01T02%3A31%3A39Z&se=2022-11-02T02%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dENue0R%2Bg5MFcGe2o%2FkPrnIfL6AdmryPnQH%2F%2BAXSEHY%3D" alt="image-alt-text">

* The information at the bottom of the screen shows that the app uses version 1.0 of voting-app and version 1.0 of voting-storage (Redis).

### Update the application

* We let's deploy a new version of the analytics component. This new version 1.1 displays totals and percentages in addition to the count for each category.

* The following diagram shows what will be running at the end of this section - only version 1.1 of our voting-analytics component has traffic routed from the voting-app component. Even though version 1.0 of our voting-analytics component continues to run and is referenced by the voting-analytics service, the Istio proxies disallow traffic to and from it.

* Let's deploy version 1.1 of the voting-analytics component. Create this component in the voting namespace:

```bash
kubectl apply -f kubernetes/step-2-update-voting-analytics-to-1.1.yaml --namespace voting
```

**Output:**
```
deployment.apps "voting-analytics-1-1" created
```

* Open the sample AKS voting app in a browser again, using the IP address of the Istio Ingress Gateway obtained in the previous step.

* Your browser alternates between the two views shown below. Since you are using a Kubernetes Service for the voting-analytics component with only a single label selector (app: voting-analytics), Kubernetes uses the default behavior of round-robin between the pods that match that selector. In this case, it is both version 1.0 and 1.1 of your voting-analytics pods.


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v2.png?st=2019-11-01T02%3A34%3A48Z&se=2022-11-02T02%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=K6qVhGe%2BKuPamH69IVCBoJeUVyxO8N%2B9UbAhUj7QNxU%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v3.png?st=2019-11-01T02%3A36%3A21Z&se=2022-11-02T02%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RzxuJRXeJg%2B0mChpaludpkE75TVrE2WyTWEF51sp2T4%3D" alt="image-alt-text">

* You can visualize the switching between the two versions of the voting-analyticscomponent as follows. Remember to use the IP address of your own Istio Ingress Gateway.

* Set `INGRESS_IP` as yours

```bash
$INGRESS_IP="52.183.64.224"
(1..5) |% { (Invoke-WebRequest -Uri $INGRESS_IP).Content.Split("`n") | Select-String -Pattern "results" }
```

* The following example output shows the relevant part of the returned web site as the site switches between versions.

**Output:**

```
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2 | Dogs: 4 </div>
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2 | Dogs: 4 </div>
      <div id="results"> Cats: 2 | Dogs: 4 </div>
```

### Lock down traffic to version 1.1 of the application

Now let's lock down traffic to only version 1.1 of the voting-analytics component and to version 1.0 of the voting-storage component. You then define routing rules for all of the other components.

* A **Virtual Service** defines a set of routing rules for one or more destination services.

* A **Destination Rule** defines traffic policies and version specific policies.

* A **Policy** defines what authentication methods can be accepted on workload(s).

* Use the `kubectl apply` command to replace the Virtual Service definition on your voting-app and add Destination Rules and Virtual Services for the other components. You will add a Policy to the voting namespace to ensure that all communicate between services is secured using mutual TLS and client certificates.

* The Policy has `peers.mtls.mode` set to `STRICT` to ensure that mutual TLS is enforced between your services within the voting namespace.

* We also set the `trafficPolicy.tls.mode` to `ISTIO_MUTUAL` in all our Destination Rules. Istio provides services with strong identities and secures communications between services using mutual TLS and client certificates that Istio transparently manages.

```bash
kubectl apply -f istio/step-2-update-and-add-routing-for-all-components.yaml --namespace voting
```

* The following example output shows the new policy, destination rules, and virtual services being updated/created

**Output:**
```
virtualservice.networking.istio.io "voting-app" configured
policy.authentication.istio.io "default" created
destinationrule.networking.istio.io "voting-app" created
destinationrule.networking.istio.io "voting-analytics" created
virtualservice.networking.istio.io "voting-analytics" created
destinationrule.networking.istio.io "voting-storage" created
virtualservice.networking.istio.io "voting-storage" created
```

* If you open the AKS Voting app in a browser again, only the new version 1.1 of the voting-analytics component is used by the voting-app component.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v3.png?st=2019-11-01T02%3A36%3A21Z&se=2022-11-02T02%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RzxuJRXeJg%2B0mChpaludpkE75TVrE2WyTWEF51sp2T4%3D" alt="image-alt-text">

* You can visualize that you are now only routed to version 1.1 of your voting-analytics component as follows. Remember to use the IP address of your own Istio Ingress Gateway.

* The following example output shows the relevant part of the returned web site.

```bash
$INGRESS_IP="52.183.64.224"
(1..5) |% { (Invoke-WebRequest -Uri $INGRESS_IP).Content.Split("`n") | Select-String -Pattern "results" }
```

**Output:**
```
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>
      <div id="results"> Cats: 2/6 (33%) | Dogs: 4/6 (67%) </div>     
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v3.png?st=2019-11-01T02%3A36%3A21Z&se=2022-11-02T02%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RzxuJRXeJg%2B0mChpaludpkE75TVrE2WyTWEF51sp2T4%3D" alt="image-alt-text">

### Roll out a Canary Release of an Application

* Now let's deploy a new version 2.0 of the voting-app, voting-analytics, and voting-storage components. The new voting-storage component use MySQL instead of Redis, and the voting-app and voting-analytics components are updated to allow them to use this new voting-storage component.

* The voting-app component now supports feature flag functionality. This feature flag allows you to test the canary release capability of Istio for a subset of users.

* Version 1.0 of the voting-app component, version 1.1 of the voting-analyticscomponent and version 1.0 of the voting-storage component are able to communicate with each other.

* Version 2.0 of the voting-app component, version 2.0 of the voting-analyticscomponent and version 2.0 of the voting-storage component are able to communicate with each other.

* Version 2.0 of the voting-app component are only accessible to users that have a specific feature flag set. This change is managed using a feature flag via a cookie.

* First, update the Istio Destination Rules and Virtual Services to cater for these new components. These updates ensure that you don't route traffic incorrectly to the new components and users don't get unexpected access.

```bash
kubectl apply -f istio/step-3-add-routing-for-2.0-components.yaml --namespace voting
```

* The following example output shows the Destination Rules and Virtual Services being updated.

**Output:**
```
destinationrule.networking.istio.io "voting-app" configured
virtualservice.networking.istio.io "voting-app" configured
destinationrule.networking.istio.io "voting-analytics" configured
virtualservice.networking.istio.io "voting-analytics" configured
destinationrule.networking.istio.io "voting-storage" configured
virtualservice.networking.istio.io "voting-storage" configured
```

* Next, let's add the Kubernetes objects for the new version 2.0 components. You also update the `voting-storage` service to include the `3306` port for MySQL.

* Use the following command to update new version of 2.0 components.

```bash
kubectl apply -f kubernetes/step-3-update-voting-app-with-new-storage.yaml --namespace voting
```

* The following example output shows the Kubernetes objects are successfully updated or created:

**Output:**

```
service "voting-storage" configured
secret "voting-storage-secret" created
deployment.apps "voting-storage-2-0" created
persistentvolumeclaim "mysql-pv-claim" created
deployment.apps "voting-analytics-2-0" created
deployment.apps "voting-app-2-0" created
```

* Wait until all the version 2.0 pods are running. Use the `kubectl get pods` command to view all pods in the `voting` namespace.

```bash
kubectl get pods --namespace voting
```

**Output:**
```
NAME                                    READY     STATUS    RESTARTS   AGE
voting-analytics-1-0-79fbdb99f9-fbt7r   2/2       Running   0          16m
voting-analytics-1-1-77b6987669-cdklx   2/2       Running   0          12m
voting-analytics-2-0-688f654c6-fcm27    2/2       Running   3          2m
voting-app-1-0-ffb8c5dbf-9pwqw          2/2       Running   0          16m
voting-app-1-0-ffb8c5dbf-jmxgv          2/2       Running   0          16m
voting-app-1-0-ffb8c5dbf-kxn9f          2/2       Running   0          16m
voting-app-2-0-5cf65b7ccb-fddjr         2/2       Running   2          1m
voting-app-2-0-5cf65b7ccb-jhw7w         2/2       Running   2          1m
voting-app-2-0-5cf65b7ccb-jqds6         2/2       Running   2          1m
voting-storage-1-0-cd5b4bf45-tjzgv      2/2       Running   0          16m
voting-storage-2-0-6ddd544bc8-8bm66     2/2       Running   0          2m
```

* You should now be able to switch between the version 1.0 and version 2.0 (canary) of the voting application. The feature flag toggle at the bottom of the screen sets a cookie. This cookie is used by the voting-app Virtual Service to route users to the new version 2.0.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v3.png?st=2019-11-01T02%3A36%3A21Z&se=2022-11-02T02%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RzxuJRXeJg%2B0mChpaludpkE75TVrE2WyTWEF51sp2T4%3D" alt="image-alt-text">

* Click the `set` see the voting-app version 2.0 store mysql.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/v6.png?st=2019-11-01T02%3A40%3A20Z&se=2022-11-02T02%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=of%2BVTpirmnPum0wLI%2F9EDIV6k9X9zeA8W1i2ixAEyIg%3D" alt="image-alt-text">

* The vote counts are different between the versions of the app. This difference highlights that you are using two different storage backends.

**Accessing the add-ons**

* A number of add-ons were installed by Istio in our setup above that provide additional functionality. The web applications for the add-ons are not exposed publicly via an external ip address.

* To access the add-on user interfaces, use the istioctl dashboard command. This command leverages kubectl port-forward and a random port to create a secure connection between your client machine and the relevant pod in your AKS cluster. It will then automatically open the add-on web application in your default browser.

* We added an additional layer of security for Grafana and Kiali by specifying credentials as earlier.

**Grafana**

* The analytics and monitoring dashboards for Istio are provided by Grafana. Remember to use the credentials as you created via the Grafana secret earlier when prompted. Open the Grafana dashboard securely as follows.

* Enter the password for Grafana as deployed in earlier step as secret. Username is `grafana`

* Visit `http://localhost:3000/dashboard/db/istio-mesh-dashboard` in your web browser. The Istio dashboard will look similar

* Use the following command using powershell, to port-forward the service of grafana.

**Note:** With help of `port-forwarding` you can access the application in Kubernetes cluster.

```bash
kubectl -n istio-system port-forward service/grafana 3000
```

**Output:**
```
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
```
<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/istio-grafana-%60.PNG?st=2019-11-01T10%3A36%3A07Z&se=2022-11-02T10%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5OG4461kmyUalylpkFA%2FSb6Ap33%2BI9poz3L8u9ykiuA%3D" alt="image-alt-text">

**Prometheus**

* Metrics for Istio are provided by Prometheus. Open the Prometheus dashboard securely as follows.

* Use the following command using PowerShell, to port-forward the service of Prometheus.

```bash
kubectl -n istio-system port-forward service/prometheus 9090
```

* Access the service using `http://localhost:9090`, you will get dashboard as follows.

* In the `Expression` input box at the top of the web page, enter the text `istio_requests_total`. Then, click the `Execute` button.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/prometheus-graph.PNG?st=2019-11-01T10%3A14%3A49Z&se=2022-11-02T10%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MWkGNaiIZNz%2B8igdnWC7gnOK6Lga0yyJ0Ry5BBJEJ1k%3D" alt="image-alt-text">

**Output:**

```
Forwarding from 127.0.0.1:9090 -> 9090
Forwarding from [::1]:9090 -> 9090
Handling connection for 9090
Handling connection for 9090
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/istio-promethus2.PNG?st=2019-11-01T10%3A15%3A46Z&se=2022-11-02T10%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9%2FAW%2Fzd1NI6VYD3YILxU6THKbZaLRE1pb1IpaWefafI%3D" alt="image-alt-text">

**Kiali**

* A service mesh observability dashboard is provided by Kiali. Remember to use the credentials you created via the Kiali secret earlier when prompted. Open the Kiali dashboard securely as follows.

* Use the following command in PowerShell to port-forward a kiali service.

```
kubectl -n istio-system port-forward service/kiali 20001
```

**Output:**
```
Forwarding from 127.0.0.1:20001 -> 20001
Forwarding from [::1]:20001 -> 20001
Handling connection for 20001
```
* Enter the password for Kiali as deployed in earlier step as secret. Username is `kiali`

* Use the url `localhost:20001` in browser, you will get dashboard as follows.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/kiali-login.png?st=2019-11-01T10%3A19%3A18Z&se=2022-11-02T10%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KCBb4FphMysjhnKeYevH7ZwMyoUSs7%2FRT0AacXP6%2BsQ%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/kiali-namespace.png?st=2019-11-01T10%3A21%3A46Z&se=2022-11-02T10%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8or997HR4mbpX%2FXxGpxlUOK3VXHjteaxiGBvHDX7EIk%3D" alt="image-alt-text">

* Choose `Graph`, select `versioned graph` you will see traffic similar to the one below.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/kiali-service-mesh.PNG?st=2019-11-01T11%3A11%3A39Z&se=2022-11-02T11%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KTha30PqS7WbjmOnkJh8EYek6aozjXB3Cv6HWB4obps%3D" alt="image-alt-text">

**Conclusion:**

In this lab you have explored, how to use the traffic management functionality of Istio. A sample AKS voting app is used to explore intelligent routing and canary releases. With use of dashboards like Grafana that gives details about service metrics, web-based interface for querying metric values using Prometheus. Kiali to monitor availabilty and observability in a visual way.

Congratulations! you have successfully completed the Istio lab.

Thank you for taking the training lab.
