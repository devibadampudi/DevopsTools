# Monitoring AKS cluster using Prometheus and Grafana

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#Pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Monitoring Setup](#monitoring-setup)

[Deploying Prometheus](#deploying-prometheus)

[Deploying Grafana](#deploying-grafana)

[Appendix](#appendix)

## Overview

**Prometheus**

Prometheus is an open source data monitoring tool. The combination of Prometheus & Grafana is the de-facto tool combination in the industry for deploying a data visualization setup. Grafana dashboard is used for visualizing the data whereas the backend is powered by Prometheus.

Though Prometheus too has data visualization features & stuff. Grafana is preferred for visualizing data. Queries are fired from the dashboard & the data is fetched from Prometheus.
It acts as a perfect open source data model for storing time series data.

**Grafana**

Grafana is an open source solution for running data analytics, pulling up metrics that make sense of the massive amount of data & to monitor our apps with the help of cool customizable dashboards.

Grafana connects with every possible data source, commonly referred to as databases such as Graphite, Prometheus, Influx DB, ElasticSearch, MySQL, PostgreSQL etc.

Monitoring is a crucial aspect of any Ops pipeline and for technologies like Kubernetes. A robust monitoring setup can bolster your confidence to migrate production workloads from VMs to Containers.

By the end of this lab, you will learn about monitoring AKS cluster using Promotheus and Grafana

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

6. We have initialized the enviornment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`kubectl get nodes`

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
aks-agentnodepool-24436756   Ready    agent     14m       V1.13.10
```

5. Using the command you get the default namespaces in Kubernetes cluster`kubectl get ns`

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

## Monitoring Setup

1. **Prometheus** server with persistent volume.
2. **Alert manager** server which will trigger alerts to Slack/Hipchat and/or Pagerduty/Victorops etc.
3. **Kube-state-metrics** server to expose container and pod metrics other than those exposed by cadvisor on the nodes.
4. **Grafana** server to create dashboards based on prometheus data.

**Monitoring Setup Overview**

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm%20architecture.PNG?st=2019-11-07T08%3A49%3A40Z&se=2022-11-08T08%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9XFrFtza1WXBdDjPXdera3i6Iw8YIItIQDei3%2BLlBGM%3D" alt="image-alt-text">  
 
## Deploying Prometheus

Prometheus is an open source, metrics-based monitoring system. Of course, Prometheus is far from the only one of those out there, so what makes it notable?

Prometheus does one thing and it does it well. It has a simple yet powerful data model and a query language that lets you analyse how your applications and infrastructure are performing. It does not try to solve problems outside of the metrics space, leaving those to other more appropriate tools.

**Features**

Prometheus's main features are:

* A multi-dimensional data model with time series data identified by metric name and key/value pairs
* PromQL, a flexible query language to leverage this dimensionality
* No reliance on distributed storage; single server nodes are autonomous
* Time series collection happens via a pull model over HTTP
* Pushing time series is supported via an intermediary gateway
* Targets are discovered via service discovery or static configuration
* Multiple modes of graphing and dashboarding support.

**Components**

The Prometheus ecosystem consists of multiple components, many of which are optional:

* The main Prometheus server which scrapes and stores time series data
* Client libraries for instrumenting application code
* A push gateway for supporting short-lived jobs
* Special-purpose exporters for services like HAProxy, StatsD, Graphite, etc. An alertmanager to handle alerts
* Various support tools
* Most Prometheus components are written in Go, making them easy to build and deploy as static binaries.

**When does it fit?**

Prometheus works well for recording any purely numeric time series. It fits both machine-centric monitoring as well as monitoring of highly dynamic service-oriented architectures. In a world of microservices, its support for multi-dimensional data collection and querying is a particular strength.

Prometheus is designed for reliability, to be the system you go to during an outage to allow you to quickly diagnose problems. Each Prometheus server is standalone, not depending on network storage or other remote services. You can rely on it when other parts of your infrastructure are broken, and you do not need to setup extensive infrastructure to use it.

### Configuring Prometheus

Prometheus configuration is YAML. The Prometheus download comes with a sample configuration in a file called prometheus.yml that is a good place to get started.

We have stripped out most of the comments in the example file to make it more sufficient (comments are the lines prefixed with a #).

**Prometheus**

**prometheus-0serviceaccount.yaml:** The Prometheus Service Account, ClusterRole and ClusterRoleBinding.

**prometheus-configmap.yaml:** A ConfigMap that contains three configuration files:

**alerts.yaml:** Contains a preconfigured set of alerts generated by kubernetes-mixin (which was also used to generate the Grafana dashboards). To learn more about configuring alerting rules, consult Alerting Rules from the Prometheus docs.

**prometheus.yaml:** Prometheusâ€™s main configuration file. Prometheus has been preconfigured to scrape all the components listed at the beginning of Step 2. Configuring Prometheus goes beyond the scope of this article, but to learn more, you can consult Configuration from the official Prometheus docs.

**rules.yaml:** A set of Prometheus recording rules that enable Prometheus to compute frequently needed or computationally expensive expressions, and save their results as a new set of time series. These are also generated by kubernetes-mixin, and configuring them goes beyond the scope of this article. To learn more, you can consult Recording Rules from the official Prometheus documentation.

**prometheus-service.yaml:** The Service that exposes the Prometheus StatefulSet.

**prometheus-statefulset.yaml:** The Prometheus StatefulSet, configured with 1 replicas. This parameter can be scaled depending on your needs.


* Deploy configuration of Prometheus using the following command.
* 
```
kubectl apply -f https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/Kubernetes-Monitoring-Yaml%20files/Prometheusforaks.yml?st=2020-08-04T07%3A53%3A21Z&se=2025-08-05T07%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=48jJczkuLrDzMoFd5C0d%2BY3sdibKmNDVjejOqvO6kFA%3D
```

**Output:**

```bash
namespace/monitoring created
serviceaccount/monitoring created
clusterrolebinding.rbac.authorization.k8s.io/monitoring created
clusterrole.rbac.authorization.k8s.io/monitoring created
configmap/prometheus-server-conf created
deployment.apps/prometheus-deployment created
service/prometheus-mon created
persistentvolumeclaim/prometheus-pv-claim created

```
This will create the following:

1. Service account, cluster-role and cluster-role-binding needed for Prometheus. 

2. Prometheus config map for the alerting rules. Some basic alerts are already configured in it (Such as High CPU and Memory usage for Containers and Nodes etc). Feel free to add more rules according to your use case.

3. Storage class, persistent volume and persistent volume claim for the Prometheus server data directory. This ensures data persistence in case the pod restarts.

4. Prometheus deployment with 1 replica running.

5. Service with nodeport.

6. Prometheus config map which details the scrape configs and alert manager endpoint. It should be noted that we can directly use the alert manager service name instead of the IP. If you want to scrape metrics from a specific pod or service, then it is mandatory to apply the Prometheus scrape annotations to it.

* example: 

```yaml
  metadata: 
  annotations: 
    prometheus.io/scrape: "true"
```
* we created the namespace **monitoring** using yaml files.

* Namespaces act as virtual clusters in Kubernetes. We want to make sure that we run all of the Prometheus pods and services in the monitoring namespace. When you go to list anything you deploy out, you will need to use the -n flag and define monitoring as the namespace.


**Get list of pods**

* To get a list of pods in a namespace use the command in Powershell.

```bash
kubectl -n monitoring get pods
```

**Output:**
```
NAME                                     READY   STATUS    RESTARTS   AGE
prometheus-deployment-5d4b6c8444-kk884   1/1     Running   0          18m
```

* If you want to describe the pod configuration use the following command in Powershell.

```bash
kubectl -n monitoring describe po prometheus-deployment-5d4b6c8444-kk884
```

**Output:**
```
Name:           prometheus-deployment-5d4b6c8444-kk884
Namespace:      monitoring
Priority:       0
Node:           aks-agentpool-12067211-0/10.240.0.4
Start Time:     Wed, 13 Nov 2019 16:04:29 +0530
Labels:         app=prometheus-server
                pod-template-hash=5d4b6c8444
Annotations:    <none>
Status:         Pending
IP:
Controlled By:  ReplicaSet/prometheus-deployment-5d4b6c8444
Containers:
  prometheus:
    Container ID:
    Image:         quay.io/prometheus/prometheus:v2.4.3
    Image ID:
    Port:          9090/TCP
    Host Port:     0/TCP
    Args:
      --config.file=/etc/prometheus/prometheus.yml
      --storage.tsdb.path=/prometheus/
      --web.enable-lifecycle
      --storage.tsdb.no-lockfile
      --storage.tsdb.retention=90d
      --storage.tsdb.max-block-duration=2h
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     1200m
      memory:  5G
    Requests:
      cpu:        250m
      memory:     250M
    Environment:  <none>
    Mounts:
      /etc/prometheus/ from prometheus-config-volume (ro)
      /prometheus/ from prometheus-storage-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from monitoring-token-zb6vh (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  prometheus-config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      prometheus-server-conf
    Optional:  false
  prometheus-storage-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  prometheus-pv-claim
    ReadOnly:   false
  monitoring-token-zb6vh:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  monitoring-token-zb6vh
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason                  Age                   From                               Message
  ----     ------                  ----                  ----                               -------
  Warning  FailedScheduling        18m (x4 over 18m)     default-scheduler                  persistentvolumeclaim "prometheus-pv-claim" not found
  Warning  FailedScheduling        3m23s (x38 over 18m)  default-scheduler                  pod has unbound immediate PersistentVolumeClaims
  Normal   SuccessfulAttachVolume  26s                   attachdetach-controller            AttachVolume.Attach succeeded for volume "pvc-25d80e3f-0601-11ea-984d-0613fc5aaaf7"
  Normal   Pulling                 16s                   kubelet, aks-agentpool-12067211-0  pulling image "quay.io/prometheus/prometheus:v2.4.3"
  Normal   Pulled                  7s                    kubelet, aks-agentpool-12067211-0  Successfully pulled image "quay.io/prometheus/prometheus:v2.4.3"
  Normal   Created                 1s                    kubelet, aks-agentpool-12067211-0  Created container
  Normal   Started                 1s                    kubelet, aks-agentpool-12067211-0  Started container
```

**Get list of services**

* To get a list of services in a namespace use the following command.

```bash
kubectl -n monitoring get svc
```

**Output:**
```
    NAME             TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
prometheus-mon   NodePort   10.96.29.35   <none>        9090:31472/TCP   94s
```

**Get list of configmaps**

* To get a list of configmap in a namespace use the command 

E.g. `kubectl -n <namespace> get configmap`

```bash
kubectl -n monitoring get configmap
```

**Output:**
```
NAME                     DATA   AGE
prometheus-server-conf   1      2m43s
```

**Get list of secrets**

To get a list of secrets in a namespace use the command `kubectl -n monitoring get secrets`

```bash
kubectl -n monitoring get secrets
```

**Output:**

```
 NAME                     TYPE                                  DATA   AGE
default-token-fxljv      kubernetes.io/service-account-token   3      3m19s
monitoring-token-9qfrq   kubernetes.io/service-account-token   3      3m18s

```
**Get list of persistent volumes**

To get a list of persistent volumes in a namespace use the command `kubectl -n <namespace> get pvc`

`kubectl -n monitoring get  pvc`
```
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS      AGE
prometheus-pv-claim   Bound    pvc-25d80e3f-0601-11ea-984d-0613fc5aaaf7   5Gi        RWO            managed-premium   83s


```
**Create the busbox**

* Below is code for busybox pod. Open the notepad copy configuration of pod, paste and save it in a file busybox.yml. Make sure "All Files" is selected for "Save as Type" option. This manifest file creates a pod with name busybox1. 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox1
  labels:
    app: busybox1
spec:
  containers:
  - image: busybox
    command:
      - sleep
      - "3600"
    imagePullPolicy: IfNotPresent
    name: busybox
  restartPolicy: Always
  
```
* Create the busybox execute this command.

```bash

kubectl -n monitoring apply -f  C:\Users\PhotonUser\Desktop\busybox.yaml

```
```bash
pod busybox created

```
**Accessing Prometheus and Alertmanager**

* To connect to the Prometheus Pods, we can use kubectl port-forward to forward a local port. If youâ€™re done exploring Grafana, you can close the port-forward tunnel by hitting CTRL-C. Alternatively, you can open a new shell and create a new port-forward connection.

* Begin by listing running Pods in the monitoring namespace:

```bash
kubectl -n monitoring get pods
```

* You should see the following Pods

**Output:**
```
NAME                                    READY   STATUS    RESTARTS   AGE
prometheus-deployment-6c6d64555-fhkdt   1/1     Running   0          65s
```

* We are going to forward local port 9090 to port 9090 of the prometheus-deployment-6c6d64555-fhkdt Pod

ex: `kubectl --namespace <namspacename> port-forward <prometheus pod name> 9090`

```bash
kubectl --namespace monitoring port-forward prometheus-deployment-5d4b6c8444-kk884 9090
```

**Output:**
```
Forwarding from 127.0.0.1:9090 -> 9090
Forwarding from [::1]:9090 -> 9090
Handling connection for 9090
Handling connection for 9090
```
* This indicates that local port 9090 is being forwarded successfully to the Prometheus Pod.

Visit http://localhost:9090 in your web browser. You should see the following Prometheus Graph page.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm1.png?st=2019-11-07T09%3A11%3A00Z&se=2022-11-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8t63FAj%2FEnZIk018Qqm7s%2FpdFZGVE%2Bq%2Bs6p3lsmU1t8%3D" alt="image-alt-text">

* From here you can use PromQL, the Prometheus query language, to select the node_cpu_seconds_total.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm2.png?st=2019-11-07T09%3A11%3A25Z&se=2022-11-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VdYGdiTDHmwM2crpUa%2B1BqEpW9FRlhv%2F3xyIIMpKXEI%3D" alt="image-alt-text">

* In the Expression field, type node_cpu_seconds_total and hit Execute. You should see the list of CPU utilisation.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm4.png?st=2019-11-07T09%3A11%3A54Z&se=2022-11-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WVt9sznnrqHxLvA2%2BVDLMR8HixY9Te98Y2HZRGj31yI%3D" alt="image-alt-text">

* As these values always sum to one second per second for each cpu, the per-second rates are also the ratios of usage. We can use this to calculate the percentage of CPU used, by subtracting the idle usage from 100%:

`(avg by (instance) (irate(node_cpu_seconds_total{mode="system"}[1m])) * 100)`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm5.png?st=2019-11-07T09%3A12%3A18Z&se=2022-11-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O3A0h6mIdiXT7GptKsERB%2BwiBEhme6Y%2BOrmVLr0Pf%2FI%3D" alt="image-alt-text">

## Deploying Grafana

* Grafana is an open source solution for running data analytics, pulling up metrics that make sense of the massive amount of data & to monitor our apps with the help of cool customizable dashboards.

* Grafana connects with every possible data source, commonly referred to as databases such as Graphite, Prometheus, Influx DB, ElasticSearch, MySQL, PostgreSQL etc.

* Grafana being an open source solution also enables us to write plugins from scratch for integration with several different data sources.

* The tool helps us study, analyse & monitor data over a period of time, technically called time series analytics.

* It helps us track the user behaviour, application behaviour, frequency of errors popping up in production or a pre-prod environment, type of errors popping up & the contextual scenarios by providing relative data.

**Configuring Grafana**

**dashboards-configmap.yaml:** A ConfigMap containing the preconfigured JSON Grafana monitoring dashboards. Generating a new set of dashboards and alerts from scratch goes beyond the scope of this tutorial, but to learn more you can consult the kubernetes-mixin GitHub repo
.
**grafana-0serviceaccount.yaml:** The Grafana Service Account.

**grafana-configmap.yaml:** A ConfigMap containing a default set of minimal Grafana configuration files.

**grafana-secret.yaml:** A Kubernetes Secret containing the Grafana admin user and password. To learn more about Kubernetes Secrets, consult Secrets.

**grafana-service.yaml:** The manifest defining the Grafana Service.

**grafana-statefulset.yaml:** The  Grafana StatefulSet, configured with 1 replica, which is not scalable. Scaling Grafana is beyond the scope of this tutorial. To learn how to create a highly available Grafana set up, you can consult How to setup Grafana for High Availability from the official Grafana docs.

**kube-state-metrics**

**kube-state-metrics-0serviceaccount.yaml:** The kube-state-metrics Service Account and ClusterRole. To learn more about ClusterRoles, consult Role and ClusterRole from the Kubernetes docs.

**kube-state-metrics-deployment.yaml:** The main kube-state-metrics Deployment manifest, configured with 1 dynamically scalable replica using addon-resizer.

**kube-state-metrics-service.yaml:** The Service exposing the kube-state-metrics Deployment.

**node-exporter**

**node-exporter-0serviceaccount.yaml:** The node-exporter Service Account.

**node-exporter-ds.yaml:** The node-exporter DaemonSet manifest. Since node-exporter is a DaemonSet, a node-exporter Pod runs on each Node in the cluster.
By now, we have deployed the core of our monitoring system (metric scrape and storage), it is time to put it all together and create dashboards.


* Deploy the yaml configuration code of Grafana using the following command in Powershell.

```bash
kubectl apply -f https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/Kubernetes-Monitoring-Yaml%20files/Grafanaforaks.yml?st=2020-08-04T08%3A02%3A23Z&se=2025-08-05T08%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nAXzmg5bsbXecYbgfbbw68sglYcQkywhUIgoTJ5XtqA%3D
```

* Grafana configuration file deploys the following things shown below.

**Output:**
```
deployment.extensions/grafana-mon-core created
secret/grafana created
service/grafana created
persistentvolumeclaim/grafana-pv-claim created
daemonset.extensions/node-exporter created
deployment.apps/kube-state-metrics created
clusterrolebinding.rbac.authorization.k8s.io/kube-state-metrics created
clusterrole.rbac.authorization.k8s.io/kube-state-metrics created
serviceaccount/kube-state-metrics created
service/kube-state-metrics created
configmap/grafana-config created
```

**Get list of pods**

* To get a list of pods in a namespace use the command ` kubectl -n <namespace> get pods`

```bash
kubectl -n monitoring get po
```

**Output:**
```
NAME                                    READY   STATUS    RESTARTS   AGE
grafana-mon-core-75bc8cc686-nwj4x       1/1     Running   0          98s
kube-state-metrics-58f7fb766c-8rnrg     2/2     Running   0          89s
node-exporter-5jshk                     1/1     Running   0          95s
node-exporter-cpq92                     1/1     Running   0          95s
node-exporter-p7h9t                     1/1     Running   0          95s
prometheus-deployment-6c6d64555-fhkdt   1/1     Running   0          9m54s
```

**Get list of services**

* To get a list of services in a namespace use the command ` kubectl -n <namespace> get svc`

```bash
kubectl -n monitoring get svc
```

**Output:**
```
NAME                 TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
grafana              NodePort   10.0.5.8       <none>        3000:32663/TCP                  22m
kube-state-metrics   NodePort   10.0.209.109   <none>        8080:32109/TCP,8081:32541/TCP   21m
prometheus-mon       NodePort   10.0.206.66    <none>        9090:31472/TCP                  76m
```

**Get list of configmaps**

* To get a list of configmaps in a namespace use the following command in Powershell.

E.g. `kubectl -n <namespace> get configmaps`

```bash
kubectl -n monitoring get configmaps
```

**Output:**
```
grafana-config           2      22m
prometheus-server-conf   1      76m
```

**Get list of secrets**

* To get a list of secrets in a namespace use the following command in Powershell.

E.g. `kubectl -n <namespace> get secrets`

```bash
kubectl -n monitoring get secrets
```

**Output:**
```
NAME                             TYPE                                  DATA   AGE
default-token-lm2n8              kubernetes.io/service-account-token   3      76m
grafana                          Opaque                                2      22m
kube-state-metrics-token-qct5n   kubernetes.io/service-account-token   3      22m
monitoring-token-zb6vh           kubernetes.io/service-account-token   3      76m
```

**Get list of persistent volumes**

* To get a list of persistent volumes in a namespace use the following command.

E.g. `kubectl -n <namespace> get pvc`

```bash
kubectl -n monitoring get pvc
```

**Output:**
```
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS      AGE
grafana-pv-claim      Bound    pvc-da8718c6-0606-11ea-984d-0613fc5aaaf7   5Gi        RWO            managed-premium   17m
prometheus-pv-claim   Bound    pvc-25d80e3f-0601-11ea-984d-0613fc5aaaf7   5Gi        RWO            managed-premium   58m
```

* Forwarding a Local Port to Access the Grafana Service

* If you donâ€™t want to expose the Grafana Service externally, you can also forward local port 3000 into the cluster directly to a Grafana Pod using kubectl port-forward.

E.g. `kubectl --namespace <namespacename> port-forward  <grafana pod name> 3000`

```bash
kubectl --namespace monitoring port-forward  grafana-mon-core-75bc8cc686-nwj4x  3000
```

**Output:**
```
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
Handling connection for 3000
Handling connection for 3000
Handling connection for 3000
Handling connection for 3000
Handling connection for 3000
```
* This will forward local port 3000 to containerPort 3000 of the Grafana Pod sammy-cluster-monitoring-grafana-0. To learn more about forwarding ports into a Kubernetes cluster, consult Use Port Forwarding to Access Applications in a Cluster.

* Visit http://localhost:3000 in your web browser. You should see the following Grafana login page.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf1.png?st=2019-11-07T09%3A12%3A59Z&se=2022-11-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WjIbH61piaJI8N%2BD5ncfGCP%2FsTWWuSxH%2B45WvzUZKkw%3D" alt="image-alt-text">

* To log in, use the default username **admin** and the password **admin**.

* Youâ€™ll be brought to the following Home Dashboard. Click the **ADD data source**.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf2.png?st=2019-11-07T09%3A13%3A22Z&se=2022-11-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2v90xqp1uJPzkr2BsVUhxblpE%2BizWEUelcqA7ZGkaRE%3D" alt="image-alt-text">

* After clicking the **ADD data source** select the Promretheus.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf3.png?st=2019-11-07T09%3A13%3A49Z&se=2022-11-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UWPmU9TNWPM3xCLl7MmERvlqR%2BFkdE3Q8D%2B6VkLHauE%3D" alt="image-alt-text">

* The HTTP protocol, **prometheus service name** and port of you Prometheus server (default port is usually 9090)

```bash
kubectl -n monitoring get svc
```

**Output:**
```
    NAME             TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
prometheus-mon    NodePort      10.0.206.66        <none>   9090:31472/TCP   94s
```

* URL: `http://prometheus-mon:9090`

* Wishlisted cookies: alerting

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf4.png?st=2019-11-07T09%3A14%3A11Z&se=2022-11-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vCNwIhRrQTG5x2g0DBuDFY0ww0LTk1ih4fs9FUCZoEk%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf5.png?st=2019-11-07T09%3A14%3A43Z&se=2022-11-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HL3xgSCr99t0uyXws6UdO75STHCcWTOGgo7P0b5UbTo%3D" alt="image-alt-text">

* In the left-hand navigation bar, select the Dashboards button, then click on Manage.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf10.png?st=2019-11-07T09%3A15%3A25Z&se=2022-11-08T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BzOMxgKom4%2BsMAfLWlp9%2FUofBq8TeRQRVXzaVqweKHI%3D" alt="image-alt-text">

**Alerts linux nodes Dashboard**

* In the Grafana.com dashboard input, add the **dashboard ID** we want to use: 5984 and click Load.

* On the next screen select a name for your dashboard and select Prometheus as the datasource for it and click Import.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf7.png?st=2019-11-07T09%3A16%3A07Z&se=2022-11-08T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=E0bViS3emtR2OPRnJ3HbHQ1VYKZJyBBA6uu8WuFl%2FDA%3D" alt="image-alt-text">

* These dashboards are generated by kubernetes-mixin, an open-source project that allows you to create a standardized set of cluster monitoring Grafana dashboards and Prometheus alerts.

* Click in to the Alerts for Linux Nodes, which visualizes CPU, memory, disk, and network usage for a given nodes

* Alerts for Linux Nodes using prometheus and node_exporter. You can have alerts for Disk space, CPU and Memory. Also added a log of alerts and alert status.

* Right click on **linux Node cpu usage** and edit the query and paste the given query and save then see the cpu usage of nodes.

`(avg by (instance) (irate(node_cpu_seconds_total{mode="system"}[1m])) * 100)`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf8.png?st=2019-11-07T09%3A17%3A17Z&se=2022-11-08T09%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v8yWnoeH3vPATJL45E6YOwc4GRwHY%2FuRLL8iCYyNjtU%3D" alt="image-alt-text">

**Kubernetes nodes resource consumption Dashborad**

* In the Grafana.com dashboard input, add the dashboard ID we want to use: 8739 and click Load.

* On the next screen select a name for your dashboard and select Prometheus as the datasource for it and click Import.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf11.png?st=2019-11-07T09%3A19%3A31Z&se=2022-11-08T09%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9%2BRCvmO6XVvkiVSOGRIXanvBgacJZT3nMk9nQ9BTXM0%3D" alt="image-alt-text">

* Simple and straight forward Resource consumption charts for an entire Kubernetes cluster and split per cluster node.

**Conclusion:** Congratulations! You have successfully completed the AKS cluster monitoring using Prometheus and Grafana! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix

### References

 [https://www.digitalocean.com/community/tutorials/how-to-set-up-a-kubernetes-monitoring-stack-with-prometheus-grafana-and-alertmanager-on-digitalocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-kubernetes-monitoring-stack-with-prometheus-grafana-and-alertmanager-on-digitalocean)

 [https://www.8bitmen.com/what-is-grafana-why-use-it-everything-you-should-know-about-it/](https://www.8bitmen.com/what-is-grafana-why-use-it-everything-you-should-know-about-it/)
