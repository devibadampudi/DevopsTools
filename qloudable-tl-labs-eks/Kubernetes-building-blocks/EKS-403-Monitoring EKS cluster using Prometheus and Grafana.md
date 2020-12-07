# Monitoring EKS cluster using Prometheus and Grafana

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#Pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

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

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects monitoring EKS cluster using Prometheus and Grafana. You will start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Cloud Infrastructure, then move into actually creating, editing,and managing objects as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you will learn about monitoring EKS cluster using Prometheus and Grafana


## Pre-Requisites

None required


## Accessing the EKS cluster

### Sign in to AWS Management console

* Sign in using your Account ID, user name and password. Use the login option under **AWS Management console**

* Credentials will be provided here, copy these information and paste corresponding values in the AWS Management console.

* **AccountID:** {{Account_ID}}
* **UserName:** {{User_Name}}
* **Password:** {{Password}}
* **Region:** {{Region}}

* Mention account-id from the above information, then click on `Next`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

* Mention Username and password from the above information

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

* Once you were provided all those information correctly you will be able to see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >


* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

* Click Apps icon in the toolbar and select **Powershell** to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-23T06%3A16%3A39Z&se=2022-10-24T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Gg0Ouxr68ThRowxFznGsXgXiaWWNOTj7kM7gXm34dGs%3D" alt="image-alt-text" >

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Cluster-region}}

* **Output-format:** json

* Need to configure the AWS credentials for accessing the cluster run the command `aws configure` then enter the  specified credentials as you get previous step.

`aws configure` 

```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json

```

* **Cluster-region:** {{Cluster-region}}

* **Cluster-name:** {{Cluster-name}}

* Run the following command to generate kubeconfig file for cluster.

 aws eks --region {{Cluster-region}} update-kubeconfig --name {{Cluster-name}}

 
 ```bash
 aws eks --region {{Cluster-region}} update-kubeconfig --name {{Cluster-name}}
 ```

* We have initialized the environment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`$ kubectl get nodes`

**Output:**

```
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```

5. using this command you get the default namespaces `kubectl get ns`

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
4. **Grafana** server to create dashboards based on Prometheus data.

**Monitoring Setup Overview**

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm%20architecture.PNG?st=2019-11-07T08%3A49%3A40Z&se=2022-11-08T08%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9XFrFtza1WXBdDjPXdera3i6Iw8YIItIQDei3%2BLlBGM%3D" alt="image-alt-text">  
 
## Deploying Prometheus

Prometheus is an open source, metrics-based monitoring system. Of course, Prometheus is far from the only one of those out there, so what makes it notable?

Prometheus does one thing and it does it well. It has a simple yet powerful data model and a query language that lets you analyze how your applications and infrastructure are performing. It does not try to solve problems outside of the metrics space, leaving those to other more appropriate tools.

**Features**

Prometheus's main features are:

* a multi-dimensional data model with time series data identified by metric name and key/value pairs
* PromQL, a flexible query language to leverage this dimensionality
* no reliance on distributed storage; single server nodes are autonomous
* time series collection happens via a pull model over HTTP
* pushing time series is supported via an intermediary gateway
* targets are discovered via service discovery or static configuration
* multiple modes of graphing and dashboarding support.

**Components**

The Prometheus ecosystem consists of multiple components, many of which are optional:

* the main Prometheus server which scrapes and stores time series data
* client libraries for instrumenting application code
* a push gateway for supporting short-lived jobs
* special-purpose exporters for services like HAProxy, StatsD, Graphite, etc.
an alertmanager to handle alerts
* various support tools
* Most Prometheus components are written in Go, making them easy to build and deploy as static binaries.


**When does it fit?**

Prometheus works well for recording any purely numeric time series. It fits both machine-centric monitoring as well as monitoring of highly dynamic service-oriented architectures. In a world of microservices, its support for multi-dimensional data collection and querying is a particular strength.

Prometheus is designed for reliability, to be the system you go to during an outage to allow you to quickly diagnose problems. Each Prometheus server is standalone, not depending on network storage or other remote services. You can rely on it when other parts of your infrastructure are broken, and you do not need to setup extensive infrastructure to use it.

### Configuring Prometheus

Prometheus configuration is YAML. The Prometheus download comes with a sample configuration in a file called prometheus.yml that is a good place to get started.

We've stripped out most of the comments in the example file to make it more succinct (comments are the lines prefixed with a #).

**Prometheus**

**prometheus-0serviceaccount.yaml:** The Prometheus Service Account, ClusterRole and ClusterRoleBinding.

**prometheus-configmap.yaml:** A ConfigMap that contains three configuration files:

**alerts.yaml:** Contains a preconfigured set of alerts generated by Kuberentes-mix (which was also used to generate the Grafana dashboards). To learn more about configuring alerting rules, consult Alerting Rules from the Prometheus docs.

**prometheus.yaml:** Prometheus’s main configuration file. Prometheus has been preconfigured to scrape all the components listed at the beginning of Step 2. Configuring Prometheus goes beyond the scope of this article, but to learn more, you can consult Configuration from the official Prometheus docs.

**rules.yaml:** A set of Prometheus recording rules that enable Prometheus to compute frequently needed or computationally expensive expressions, and save their results as a new set of time series. These are also generated by Kuberentes-mix, and configuring them goes beyond the scope of this article. To learn more, you can consult Recording Rules from the official Prometheus documentation.

**prometheus-service.yaml:** The Service that exposes the Prometheus StatefulSet.

**prometheus-statefulset.yaml:** The Prometheus StatefulSet, configured with 1 replicas. This parameter can be scaled depending on your needs

* Save the following yaml code in a notepad with a filename `prometheus.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: monitoring
  namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: monitoring
subjects:
  - kind: ServiceAccount
    name: monitoring
    namespace: monitoring
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: monitoring
rules:
- apiGroups: [""]
  resources:
  - nodes
  - nodes/proxy
  - services
  - services/proxy
  - endpoints
  - pods
  - pods/proxy
  verbs: ["get", "list", "watch"]
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-server-conf
  labels:
    name: prometheus-server-conf
  namespace: monitoring
data:
  prometheus.yml: |-
    global:
      scrape_interval: 5s
      evaluation_interval: 5s
    
    scrape_configs:
    - job_name: 'kubernetes-nodes-cadvisor'
      scrape_interval: 10s
      scrape_timeout: 10s
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      kubernetes_sd_configs:
        - role: node
      relabel_configs:
        - action: labelmap
          regex: __meta_kubernetes_node_label_(.+)
        # Only for Kubernetes ^1.7.3.
        # See: https://github.com/prometheus/prometheus/issues/2916
        - target_label: __address__
          replacement: kubernetes.default.svc:443
        - source_labels: [__meta_kubernetes_node_name]
          regex: (.+)
          target_label: __metrics_path__
          replacement: /api/v1/nodes/${1}/proxy/metrics/cadvisor
      metric_relabel_configs:
        - action: replace
          source_labels: [id]
          regex: '^/machine\.slice/machine-rkt\\x2d([^\\]+)\\.+/([^/]+)\.service$'
          target_label: rkt_container_name
          replacement: '${2}-${1}'
        - action: replace
          source_labels: [id]
          regex: '^/system\.slice/(.+)\.service$'
          target_label: systemd_service_name
          replacement: '${1}'
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
        - role: pod
      relabel_configs:
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
          action: replace
          regex: (.+):(?:\d+);(\d+)
          replacement: ${1}:${2}
          target_label: __address__
        - action: labelmap
          regex: __meta_kubernetes_pod_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_pod_name]
          action: replace
          target_label: kubernetes_pod_name
        - source_labels: [__meta_kubernetes_pod_container_port_number]
          action: keep
          regex: 9\d{3}
    - job_name: 'kubernetes-apiservers'
      kubernetes_sd_configs:
        - role: endpoints
      scheme: https 
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      relabel_configs:
        - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
          action: keep
          regex: default;kubernetes;https
    - job_name: 'kubernetes-service-endpoints'
      kubernetes_sd_configs:
        - role: endpoints
      relabel_configs:
        - action: labelmap
          regex: __meta_kubernetes_service_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_service_name]
          action: replace
          target_label: kubernetes_name
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]
          action: replace
          target_label: __scheme__
          regex: (https?)
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
          action: replace
          target_label: __address__
          regex: (.+)(?::\d+);(\d+)
          replacement: $1:$2
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus-deployment
  namespace: monitoring
spec:
  replicas: 1
  #podManagementPolicy: "Parallel"
  #updateStrategy:
  # type: "RollingUpdate"
  selector:
    matchLabels:
      app: prometheus-server
  template:
    metadata:
      labels:
        app: prometheus-server
    spec:
      #priorityClassName: system-cluster-critical
      serviceAccountName: monitoring
      #initContainers:
      #- name: "init-chown-data"
      #  image: "busybox:latest"
      #  imagePullPolicy: "IfNotPresent"
      #  command: ["chown", "-R", "65534:65534", "/prometheus/"]
      #  volumeMounts:
      #  - name: prometheus-storage-volume
      #    mountPath: /prometheus/
      #    subPath: ""
      containers:
        - name: prometheus
          image: quay.io/prometheus/prometheus:v2.4.3
          imagePullPolicy: "IfNotPresent"
          #nodeName: test-monitoring
          args:
            - "--config.file=/etc/prometheus/prometheus.yml"
            - "--storage.tsdb.path=/prometheus/"
            - "--web.enable-lifecycle"
            - "--storage.tsdb.no-lockfile"
            - "--storage.tsdb.retention=90d"
            - "--storage.tsdb.max-block-duration=2h"
           # - "--volume-dir=/etc/prometheus/"
           # - "--webhook-url=http://localhost:9090/-/reload"
          resources:
            requests:
              memory: "250M"
              cpu: "250m"
            limits:
              memory: "5G"
              cpu: "1200m"
          ports:
            - name: prometheus
              containerPort: 9090
          #readinessProbe:
           # httpGet:
           #   path: /-/ready
           #   port: 9090
           # initialDelaySeconds: 30
           # timeoutSeconds: 30
          #livenessProbe:
          #  httpGet:
          #    path: /-/healthy
          #    port: 9090
          #  initialDelaySeconds: 30
          #  timeoutSeconds: 30
          volumeMounts:
            - name: prometheus-config-volume
              mountPath: /etc/prometheus/
              readOnly: true
            - name: prometheus-storage-volume
              mountPath: /prometheus/
              subPath: ""
              #readOnly: true     
      securityContext:
        fsGroup: 0
        runAsNonRoot: false
        runAsUser: 0
      #terminationGracePeriodSeconds: 300    
      volumes:
        - name: prometheus-config-volume
          configMap:
            defaultMode: 420
            name: prometheus-server-conf
        - name: prometheus-storage-volume
          persistentVolumeClaim:
            claimName: prometheus-pv-claim
            #readOnly: true
---
apiVersion: v1
kind: Service
metadata: 
  annotations: 
    prometheus.io/scrape: "true"
 #   cloud.google.com/load-balancer-type: "Internal"
  name: prometheus-mon
  namespace: monitoring
  labels:
    name: prometheus
spec:
  selector:
    app: prometheus-server
  type: NodePort
  ports:
  - name: prometheus
    protocol: TCP
    port: 9090
    nodePort: 31472
    targetPort: 9090
---
kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: prometheus-storage
  namespace: monitoring
provisioner: kubernetes.io/azure-disk
reclaimPolicy: Retain
parameters:
  storageaccounttype: Premium_LRS
  kind: Managed
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: prometheus-storage-volume
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain
mountOptions:
  - debug
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: prometheus-pv-claim
  namespace: monitoring
  labels:
    name: prometheus-pv-claim
spec:
  storageClassName: prometheus-storage-volume
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
```
* Deploy Prometheus using the following command.

```bash
kubectl apply -f Prometheus.yaml
```
**Output:**

```
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

To get a list of pods in a namespace use the command `kubectl -n <namespace> get pods`

```bash
kubectl -n monitoring get pods
```

**Output:**

```
NAME                                     READY   STATUS    RESTARTS   AGE
prometheus-deployment-5d4b6c8444-85wtx   1/1     Running   0          2m14s
```
* If you want to describe the pod using this command.

* **Note:** Replace pod name with yours

```bash
kubectl -n monitoring describe po prometheus-deployment-5d4b6c8444-85wtx
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


To get a list of services in a namespace use the command `kubectl -n monitoring get svc`

```bash
kubectl-n monitoring get svc
```

**Output:**

```
    NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
prometheus-mon   NodePort   172.20.240.13   <none>        9090:31472/TCP   2m58s
```

**Get list of configmaps**

To get a list of configmap in a namespace use the command `kubectl -n monitoring get configmap`

```bash
kubectl -n monitoring get configmap
```

**Output:**

```
NAME                     DATA   AGE
prometheus-server-conf   1      3m19s
```

**Get list of secrets**

* To get a list of secrets in a namespace use the following command.

 ```bash
 kubectl -n monitoring get secrets
 ```
 
**Output:**
```
 NAME                     TYPE                                  DATA   AGE
default-token-fxljv      kubernetes.io/service-account-token   3      3m19s
monitoring-token-9qfrq   kubernetes.io/service-account-token   3      3m18s
```

**Get list of storage classes**

To get a list of storage classes in a namespace use the command `kubectl -n <namespace> get sc`

```bash
kubectl -n monitoring get  sc
```

**Output:**
```
NAME                        PROVISIONER             AGE
prometheus-storage-volume   kubernetes.io/aws-ebs   96s
```
**Get list of persistent volumes**

To get a list of persistent volumes in a namespace use the command `kubectl -n <namespace> get pvc`

`kubectl -n monitoring get  pvc`

**Output:**
```
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                AGE
prometheus-pv-claim   Bound    pvc-7707de2f-06ae-11ea-8c52-12355046b523   50Gi       RWO            prometheus-storage-volume   108s
```
**Create the busybox**

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
  restartPolicy: Alway
  
```
* Create the busybox execute this command.

```bash
kubectl apply -f monitoring E:\Kubernetes-Monitoring\Monitoring\busybox.yaml
```

**Output:**
```
pod busybox created
```

**Accessing Prometheus and Alertmanager**

To connect to the Prometheus Pods, we can use kubectl port-forward to forward a local port. If you’re done exploring Grafana, you can close the port-forward tunnel by hitting CTRL-C. Alternatively, you can open a new shell and create a new port-forward connection.

Begin by listing running Pods in the monitoring namespace:


```bash
kubectl -n monitoring get pods
```

You should see the following Pods:

**Output:**

```
NAME                                    READY   STATUS    RESTARTS   AGE
prometheus-deployment-6c6d64555-fhkdt   1/1     Running   0          65s
```

* We are going to forward local port 9090 to port 9090 of the prometheus-deployment-6c6d64555-fhkdt Pod.

**Note:** Make sure replace pod name with yours.


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

Visit http://localhost:9090 in your web browser. You should see the following Prometheus Graph page:

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/pm1.png?st=2019-11-07T09%3A11%3A00Z&se=2022-11-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8t63FAj%2FEnZIk018Qqm7s%2FpdFZGVE%2Bq%2Bs6p3lsmU1t8%3D" alt="image-alt-text">

In the Expression field, type `container_cpu_usage_seconds_total` and hit `Execute`. You should see the list of cpu utilisation.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/container-cpu.png?st=2020-02-21T10%3A12%3A07Z&se=2021-02-22T10%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mYYnl5senVE1NlVOfF0c9pw85XHU80TIR5zCjmT2znI%3D" alt="image-alt-text">


As these values always sum to one second per second for each CPU, the per-second rates are also the ratios of usage. We can use this to calculate the percentage of CPU used, by subtracting the idle usage from 100%:

`rate(container_cpu_user_seconds_total[30s]) * 100`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/cpu-example-seconds.png?st=2020-02-21T10%3A20%3A35Z&se=2021-02-22T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9NNvl9dG1Plsy0babtHzD17h2xkGVKR3PrgqkM72tcY%3D" alt="image-alt-text">


## Deploying Grafana

Grafana is an open source solution for running data analytics, pulling up metrics that make sense of the massive amount of data & to monitor our apps with the help of cool customizable dashboards.

Grafana connects with every possible data source, commonly referred to as databases such as Graphite, Prometheus, Influx DB, ElasticSearch, MySQL, PostgreSQL etc.

Grafana being an open source solution also enables us to write plugins from scratch for integration with several different data sources.

The tool helps us study, analyse & monitor data over a period of time, technically called time series analytics.

It helps us track the user behavior, application behavior, frequency of errors popping up in production or a pre-prod environment, type of errors popping up & the contextual scenarios by providing relative data.

 
**Configuring Grafana**

**dashboards-configmap.yaml:** A ConfigMap containing the preconfigured JSON Grafana monitoring dashboards. Generating a new set of dashboards and alerts from scratch goes beyond the scope of this tutorial, but to learn more you can consult the Kuberentes-mixin GitHub repo
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

* Save the following code in a notepad, with a filename `Grafana.yaml`

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: grafana-mon-core
  namespace: monitoring
  labels:
    app: grafana
    component: core
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: grafana
        component: core
    spec:
      securityContext:
        runAsUser: 0
      containers:
      - image: grafana/grafana:6.3.3
        name: grafana-core
        imagePullPolicy: IfNotPresent
      #nodeName: test-monitoring
      
        # env:
        resources:
          # keep request = limit to keep this container in guaranteed class
          limits:
            cpu: 100m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi
        env:
          # The following env variables set up basic auth twith the default admin user and admin password.
          - name: GF_AUTH_BASIC_ENABLED
            value: "true"
          - name: GF_SECURITY_ADMIN_USER
            valueFrom:
              secretKeyRef:
                name: grafana
                key: admin-username
          - name: GF_SECURITY_ADMIN_PASSWORD
            valueFrom:
              secretKeyRef:
                name: grafana
                key: admin-password
          - name: GF_AUTH_ANONYMOUS_ENABLED
            value: "false"
          # - name: GF_AUTH_ANONYMOUS_ORG_ROLE
          #   value: Admin
          # does not really work, because of template variables in exported dashboards:
          # - name: GF_DASHBOARDS_JSON_ENABLED
          #   value: "true"
        readinessProbe:
          httpGet:
            path: /login
            port: 3000
          # initialDelaySeconds: 30
          # timeoutSeconds: 1
        volumeMounts:
        - mountPath: /etc/grafana
          name: config-volume
        - mountPath: /var/lib/grafana
          name: grafana-storage
           
      securityContext:
        fsGroup: 0
        runAsNonRoot: false
        runAsUser: 0
      volumes:
       - name: config-volume
         configMap:
          name: grafana-config
       - name: grafana-storage
         persistentVolumeClaim:
          claimName: grafana-pv-claim
---
apiVersion: v1
kind: Secret
data:
  admin-password: YWRtaW4=
  admin-username: YWRtaW4=
metadata:
  name: grafana
  namespace: monitoring
type: Opaque
---
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: monitoring
  labels:
    app: grafana
    component: core
spec:
  selector:
    app: grafana
  type: NodePort
  ports:
  - name: grafana
    protocol: TCP
    port: 3000
    nodePort: 32663
    targetPort: 3000
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: grafana-storage-volume
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain
mountOptions:
  - debug
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: grafana-pv-claim
  namespace: monitoring
  labels:
    name: grafana-pv-claim
spec:
  storageClassName: grafana-storage-volume
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
---
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
  labels:
    name: node-exporter
spec:
  template:
    metadata:
      labels:
        name: node-exporter
      annotations:
         prometheus.io/scrape: "true"
         prometheus.io/port: "9100"
    spec:
      #serviceAccountName: cluster-reader
      hostPID: true
      hostIPC: true
      hostNetwork: true
      securityContext:
        runAsUser: 0
      containers:
        - name: node-exporter
          image: quay.io/prometheus/node-exporter:v0.16.0
          ports:
            - containerPort: 9100
              name: node-exporter
              protocol: TCP
          resources:
            requests:
              cpu: 10m
              memory: 32Mi
            limits:
              cpu: 100m
              memory: 64Mi
          securityContext:
            privileged: true
          args:
            - --path.procfs=/host/proc
            - --path.sysfs=/host/sys
            #- --path.rootfs=/rootfs
            #- --collector.filesystem.ignored-mount-points=^/(sys|proc|dev|host|etc|rootfs)($|/)
            - --collector.filesystem.ignored-mount-points=^\/rootfs\/(sys|proc|dev|var\/lib|run\/docker|home\/kubernetes)\/.*
            - --collector.filesystem.ignored-fs-types=^(autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs)$
          volumeMounts:
            - name: dev
              mountPath: /host/dev
            - name: proc
              mountPath: /host/proc
            - name: sys
              mountPath: /host/sys
            - name: rootfs
              mountPath: /rootfs
      volumes:
        - name: proc
          hostPath:
            path: /proc
        - name: dev
          hostPath:
            path: /dev
        - name: sys
          hostPath:
            path: /sys
        - name: rootfs
          hostPath:
            path: /
 
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-state-metrics
  namespace: monitoring
spec:
  selector:
    matchLabels:
      k8s-app: kube-state-metrics
  replicas: 1
  template:
    metadata:
      labels:
        k8s-app: kube-state-metrics
    spec:
      serviceAccountName: kube-state-metrics
      containers:
      - name: kube-state-metrics
        image: quay.io/mxinden/kube-state-metrics:v1.4.0-gzip.3
        ports:
        - name: http-metrics
          containerPort: 8080
        - name: telemetry
          containerPort: 8081
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 5
          timeoutSeconds: 5
      - name: addon-resizer
        image: k8s.gcr.io/addon-resizer:1.8.3
        resources:
          limits:
            cpu: 150m
            memory: 50Mi
          requests:
            cpu: 150m
            memory: 50Mi
        env:
          - name: MY_POD_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          - name: MY_POD_NAMESPACE
            valueFrom:
              fieldRef:
                fieldPath: metadata.namespace
        command:
          - /pod_nanny
          - --container=kube-state-metrics
          - --cpu=100m
          - --extra-cpu=1m
          - --memory=100Mi
          - --extra-memory=2Mi
          - --threshold=5
          - --deployment=kube-state-metrics
---
# ---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kube-state-metrics
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: kube-state-metrics
subjects:
- kind: ServiceAccount
  name: kube-state-metrics
  namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: kube-state-metrics
rules:
- apiGroups: [""]
  resources:
  - nodes
  - pods
  - services
  - resourcequotas
  - replicationcontrollers
  - limitranges
  verbs: ["list", "watch"]
- apiGroups: ["extensions"]
  resources:
  - daemonsets
  - deployments
  - replicasets
  verbs: ["list", "watch"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kube-state-metrics
  namespace: monitoring
---
apiVersion: v1
kind: Service
metadata:
  name: kube-state-metrics
  namespace: monitoring
  labels:
    k8s-app: kube-state-metrics
  annotations:
    prometheus.io/scrape: 'true'
spec:
  ports:
  - name: http-metrics
    port: 8080
    nodePort: 32109
    targetPort: http-metrics
    protocol: TCP
  - name: telemetry
    port: 8081
    nodePort: 32541
    targetPort: telemetry
    protocol: TCP
  selector:
    k8s-app: kube-state-metrics
  type: NodePort

---
apiVersion: v1
kind: ConfigMap
data:
  grafana.ini: |
    ##################### Grafana Configuration Example #####################
    #
    # Everything has defaults so you only need to uncomment things you want to
    # change

    # possible values : production, development
    ;app_mode = production

    # instance name, defaults to HOSTNAME environment variable value or hostname if HOSTNAME var is empty
    ;instance_name = ${HOSTNAME}

    #################################### Paths ####################################
    [paths]
    # Path to where grafana can store temp files, sessions, and the sqlite3 db (if that is used)
    ;data = /var/lib/grafana

    # Temporary files in `data` directory older than given duration will be removed
    ;temp_data_lifetime = 24h

    # Directory where grafana can store logs
    ;logs = /var/log/grafana

    # Directory where grafana will automatically scan and look for plugins
    ;plugins = /var/lib/grafana/plugins

    # folder that contains provisioning config files that grafana will apply on startup and while running.
    ;provisioning = conf/provisioning

    #################################### Server ####################################
    [server]
    # Protocol (http, https, socket)
    protocol = http

    # The ip address to bind to, empty will bind to all interfaces
    ;http_addr =

    # The http port  to use
    http_port = 3000

    # The public facing domain name used to access grafana from a browser
    domain = lab.com

    # Redirect to correct domain if host header does not match domain
    # Prevents DNS rebinding attacks
    ;enforce_domain = false

    # The full public facing url you use in browser, used for redirects and emails
    # If you use reverse proxy and sub path specify full url (with sub path)
    ;root_url = http://localhost:3000
    

    # Log web requests
    ;router_logging = false

    # the path relative working path
    ;static_root_path = public

    # enable gzip
    ;enable_gzip = false

    # https certs & key file
    ;cert_file =
    ;cert_key =

    # Unix socket path
    ;socket =

    #################################### Database ####################################
    [database]
    # You can configure the database connection by specifying type, host, name, user and password
    # as separate properties or as on string using the url properties.

    # Either "mysql", "postgres" or "sqlite3", it's your choice
    ;type = sqlite3
    ;host = 127.0.0.1:3306
    ;name = grafana
    ;user = root
    # If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
    ;password =

    # Use either URL or the previous fields to configure the database
    # Example: mysql://user:secret@host:port/database
    ;url =

    # For "postgres" only, either "disable", "require" or "verify-full"
    ;ssl_mode = disable

    # For "sqlite3" only, path relative to data_path setting
    ;path = grafana.db

    # Max idle conn setting default is 2
    ;max_idle_conn = 2

    # Max conn setting default is 0 (mean not set)
    ;max_open_conn =

    # Connection Max Lifetime default is 14400 (means 14400 seconds or 4 hours)
    ;conn_max_lifetime = 14400

    # Set to true to log the sql calls and execution times.
    log_queries =

    # For "sqlite3" only. cache mode setting used for connecting to the database. (private, shared)
    ;cache_mode = private

    #################################### Cache server #############################
    [remote_cache]
    # Either "redis", "memcached" or "database" default is "database"
    ;type = database

    # cache connectionstring options
    # database: will use Grafana primary database.
    # redis: config like redis server e.g. `addr=127.0.0.1:6379,pool_size=100,db=grafana`
    # memcache: 127.0.0.1:11211
    ;connstr =

    #################################### Session ####################################
    [session]
    # Either "memory", "file", "redis", "mysql", "postgres", default is "file"
    ;provider = file

    # Provider config options
    # memory: not have any config yet
    # file: session dir path, is relative to grafana data_path
    # redis: config like redis server e.g. `addr=127.0.0.1:6379,pool_size=100,db=grafana`
    # mysql: go-sql-driver/mysql dsn config string, e.g. `user:password@tcp(127.0.0.1:3306)/database_name`
    # postgres: user=a password=b host=localhost port=5432 dbname=c sslmode=disable
    ;provider_config = sessions

    # Session cookie name
    ;cookie_name = grafana_sess

    # If you use session in https only, default is false
    cookie_secure = false

    # Session life time, default is 86400
    ;session_life_time = 86400

    #################################### Data proxy ###########################
    [dataproxy]

    # This enables data proxy logging, default is false
    ;logging = false

    # How long the data proxy should wait before timing out default is 30 (seconds)
    ;timeout = 30

    # If enabled and user is not anonymous, data proxy will add X-Grafana-User header with username into the request, default is false.
    ;send_user_header = false

    #################################### Analytics ####################################
    [analytics]
    # Server reporting, sends usage counters to stats.grafana.org every 24 hours.
    # No ip addresses are being tracked, only simple counters to track
    # running instances, dashboard and error counts. It is very helpful to us.
    # Change this option to false to disable reporting.
    ;reporting_enabled = true

    # Set to false to disable all checks to https://grafana.net
    # for new vesions (grafana itself and plugins), check is used
    # in some UI views to notify that grafana or plugin update exists
    # This option does not cause any auto updates, nor send any information
    # only a GET request to http://grafana.com to get latest versions
    ;check_for_updates = true

    # Google Analytics universal tracking code, only enabled if you specify an id here
    ;google_analytics_ua_id =

    # Google Tag Manager ID, only enabled if you specify an id here
    ;google_tag_manager_id =

    #################################### Security ####################################
    [security]
    # default admin user, created on startup
    ;admin_user = admin

    # default admin password, can be changed before first start of grafana,  or in profile settings
    ;admin_password = admin

    # used for signing
    ;secret_key = SW2YcwTIb9zpOOhoPsMm

    # disable gravatar profile images
    ;disable_gravatar = false

    # data source proxy whitelist (ip_or_domain:port separated by spaces)
    ;data_source_proxy_whitelist =

    # disable protection against brute force login attempts
    ;disable_brute_force_login_protection = false

    # set to true if you host Grafana behind HTTPS. default is false.
    cookie_secure = false

    # set cookie SameSite attribute. defaults to `lax`. can be set to "lax", "strict" and "none"
    cookie_samesite = none

    #################################### Snapshots ###########################
    [snapshots]
    # snapshot sharing options
    ;external_enabled = true
    ;external_snapshot_url = https://snapshots-origin.raintank.io
    ;external_snapshot_name = Publish to snapshot.raintank.io

    # remove expired snapshot
    ;snapshot_remove_expired = true

    #################################### Dashboards History ##################
    [dashboards]
    # Number dashboard versions to keep (per dashboard). Default: 20, Minimum: 1
    ;versions_to_keep = 20

    #################################### Users ###############################
    [users]
    # disable user signup / registration
    ;allow_sign_up = true

    # Allow non admin users to create organizations
    ;allow_org_create = true

    # Set to true to automatically assign new users to the default organization (id 1)
    ;auto_assign_org = true

    # Default role new users will be automatically assigned (if disabled above is set to true)
    ;auto_assign_org_role = Viewer

    # Background text for the user field on the login page
    ;login_hint = email or username
    ;password_hint = password

    # Default UI theme ("dark" or "light")
    ;default_theme = dark

    # External user management, these options affect the organization users view
    ;external_manage_link_url =
    ;external_manage_link_name =
    ;external_manage_info =

    # Viewers can edit/inspect dashboard settings in the browser. But not save the dashboard.
    ;viewers_can_edit = false

    # Editors can administrate dashboard, folders and teams they create
    ;editors_can_admin = false

    [auth]
    # Login cookie name
    login_cookie_name = grafana_session

    # The lifetime (days) an authenticated user can be inactive before being required to login at next visit. Default is 7 days,
    login_maximum_inactive_lifetime_days = 7

    # The maximum lifetime (days) an authenticated user can be logged in since login time before being required to login. Default is 30 days.
    login_maximum_lifetime_days = 30

    # How often should auth tokens be rotated for authenticated users when being active. The default is each 10 minutes.
    token_rotation_interval_minutes = 10

    # Set to true to disable (hide) the login form, useful if you use OAuth, defaults to false
    ;disable_login_form = false

    # Set to true to disable the signout link in the side menu. useful if you use auth.proxy, defaults to false
    ;disable_signout_menu = false

    # URL to redirect the user to after sign out
    ;signout_redirect_url =

    # Set to true to attempt login with OAuth automatically, skipping the login screen.
    # This setting is ignored if multiple OAuth providers are configured.
    ;oauth_auto_login = false

    #################################### Anonymous Auth ######################
    [auth.anonymous]
    # enable anonymous access
    ;enabled = false

    # specify organization name that should be used for unauthenticated users
    ;org_name = Main Org.

    # specify role for unauthenticated users
    ;org_role = Viewer

    #################################### Github Auth ##########################
    [auth.github]
    ;enabled = false
    ;allow_sign_up = true
    ;client_id = some_id
    ;client_secret = some_secret
    ;scopes = user:email,read:org
    ;auth_url = https://github.com/login/oauth/authorize
    ;token_url = https://github.com/login/oauth/access_token
    ;api_url = https://api.github.com/user
    ;team_ids =
    ;allowed_organizations =

    #################################### Google Auth ##########################
    [auth.google]
    ;enabled = false
    ;allow_sign_up = true
    ;client_id = some_client_id
    ;client_secret = some_client_secret
    ;scopes = https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email
    ;auth_url = https://accounts.google.com/o/oauth2/auth
    ;token_url = https://accounts.google.com/o/oauth2/token
    ;api_url = https://www.googleapis.com/oauth2/v1/userinfo
    ;allowed_domains =

    #################################### Generic OAuth ##########################
    [auth.generic_oauth]
    ;enabled = false
    ;name = OAuth
    ;allow_sign_up = true
    ;client_id = some_id
    ;client_secret = some_secret
    ;scopes = user:email,read:org
    ;auth_url = https://foo.bar/login/oauth/authorize
    ;token_url = https://foo.bar/login/oauth/access_token
    ;api_url = https://foo.bar/user
    ;team_ids =
    ;allowed_organizations =
    ;tls_skip_verify_insecure = false
    ;tls_client_cert =
    ;tls_client_key =
    ;tls_client_ca =

    ; Set to true to enable sending client_id and client_secret via POST body instead of Basic authentication HTTP header
    ; This might be required if the OAuth provider is not RFC6749 compliant, only supporting credentials passed via POST payload
    ;send_client_credentials_via_post = false

    #################################### Grafana.com Auth ####################
    [auth.grafana_com]
    ;enabled = false
    ;allow_sign_up = true
    ;client_id = some_id
    ;client_secret = some_secret
    ;scopes = user:email
    ;allowed_organizations =

    #################################### Auth Proxy ##########################
    [auth.proxy]
    ;enabled = false
    ;header_name = X-WEBAUTH-USER
    ;header_property = username
    ;auto_sign_up = true
    ;ldap_sync_ttl = 60
    ;whitelist = 192.168.1.1, 192.168.2.1
    ;headers = Email:X-User-Email, Name:X-User-Name

    #################################### Basic Auth ##########################
    [auth.basic]
    ;enabled = true

    #################################### Auth LDAP ##########################
    [auth.ldap]
    enabled = false
    config_file = /etc/grafana/ldap.toml
    allow_sign_up = true

    #################################### SMTP / Emailing ##########################
    [smtp]
    ;enabled = false
    ;host = localhost:25
    ;user =
    # If the password contains # or ; you have to wrap it with trippel quotes. Ex """#password;"""
    ;password =
    ;cert_file =
    ;key_file =
    ;skip_verify = false
    ;from_address = admin@grafana.localhost
    ;from_name = Grafana
    # EHLO identity in SMTP dialog (defaults to instance_name)
    ;ehlo_identity = dashboard.example.com

    [emails]
    ;welcome_email_on_sign_up = false

    #################################### Logging ##########################
    [log]
    # Either "console", "file", "syslog". Default is console and  file
    # Use space to separate multiple modes, e.g. "console file"
    ;mode = console file

    # Either "debug", "info", "warn", "error", "critical", default is "info"
    ;level = info

    # optional settings to set different levels for specific loggers. Ex filters = sqlstore:debug
    ;filters =

    # For "console" mode only
    [log.console]
    ;level =

    # log line format, valid options are text, console and json
    ;format = console

    # For "file" mode only
    [log.file]
    ;level =

    # log line format, valid options are text, console and json
    ;format = text

    # This enables automated log rotate(switch of following options), default is true
    ;log_rotate = true

    # Max line number of single file, default is 1000000
    ;max_lines = 1000000

    # Max size shift of single file, default is 28 means 1 << 28, 256MB
    ;max_size_shift = 28

    # Segment log daily, default is true
    ;daily_rotate = true

    # Expired days of log file(delete after max days), default is 7
    ;max_days = 7

    [log.syslog]
    ;level =

    # log line format, valid options are text, console and json
    ;format = text

    # Syslog network type and address. This can be udp, tcp, or unix. If left blank, the default unix endpoints will be used.
    ;network =
    ;address =

    # Syslog facility. user, daemon and local0 through local7 are valid.
    ;facility =

    # Syslog tag. By default, the process' argv[0] is used.
    ;tag =

    #################################### Alerting ############################
    [alerting]
    # Disable alerting engine & UI features
    ;enabled = true
    # Makes it possible to turn off alert rule execution but alerting UI is visible
    ;execute_alerts = true

    # Default setting for new alert rules. Defaults to categorize error and timeouts as alerting. (alerting, keep_state)
    ;error_or_timeout = alerting

    # Default setting for how Grafana handles nodata or null values in alerting. (alerting, no_data, keep_state, ok)
    ;nodata_or_nullvalues = no_data

    # Alert notifications can include images, but rendering many images at the same time can overload the server
    # This limit will protect the server from render overloading and make sure notifications are sent out quickly
    ;concurrent_render_limit = 5

    #################################### Explore #############################
    [explore]
    # Enable the Explore section
    ;enabled = true

    #################################### Internal Grafana Metrics ##########################
    # Metrics available at HTTP API Url /metrics
    [metrics]
    # Disable / Enable internal metrics
    ;enabled           = true

    # Publish interval
    ;interval_seconds  = 10

    # Send internal metrics to Graphite
    [metrics.graphite]
    # Enable by setting the address setting (ex localhost:2003)
    ;address =
    ;prefix = prod.grafana.%(instance_name)s.

    #################################### Distributed tracing ############
    [tracing.jaeger]
    # Enable by setting the address sending traces to jaeger (ex localhost:6831)
    ;address = localhost:6831
    # Tag that will always be included in when creating new spans. ex (tag1:value1,tag2:value2)
    ;always_included_tag = tag1:value1
    # Type specifies the type of the sampler: const, probabilistic, rateLimiting, or remote
    ;sampler_type = const
    # jaeger samplerconfig param
    # for "const" sampler, 0 or 1 for always false/true respectively
    # for "probabilistic" sampler, a probability between 0 and 1
    # for "rateLimiting" sampler, the number of spans per second
    # for "remote" sampler, param is the same as for "probabilistic"
    # and indicates the initial sampling rate before the actual one
    # is received from the mothership
    ;sampler_param = 1

    #################################### Grafana.com integration  ##########################
    # Url used to import dashboards directly from Grafana.com
    [grafana_com]
    ;url = https://grafana.com

    #################################### External image storage ##########################
    [external_image_storage]
    # Used for uploading images to public servers so they can be included in slack/email messages.
    # you can choose between (s3, webdav, gcs, azure_blob, local)
    ;provider =

    [external_image_storage.s3]
    ;bucket =
    ;region =
    ;path =
    ;access_key =
    ;secret_key =

    [external_image_storage.webdav]
    ;url =
    ;public_url =
    ;username =
    ;password =

    [external_image_storage.gcs]
    ;key_file =
    ;bucket =
    ;path =

    [external_image_storage.azure_blob]
    ;account_name =
    ;account_key =
    ;container_name =

    [external_image_storage.local]
    # does not require any configuration

    [rendering]
    # Options to configure external image rendering server like https://github.com/grafana/grafana-image-renderer
    ;server_url =
    ;callback_url =

    [enterprise]
    # Path to a valid Grafana Enterprise license.jwt file
    ;license_path =

    [panels]
    ;enable_alpha = false
    # If set to true Grafana will allow script tags in text panels. Not recommended as it enable XSS vulnerabilities.
    ;disable_sanitize_html = false

  ldap.toml: |
    # To troubleshoot and get more log info enable ldap debug logging in grafana.ini
    # [log]
    # filters = ldap:debug

    [[servers]]
    # Ldap server host (specify multiple hosts space separated)
    host = "x.x.x.x"
    # Default port is 389 or 636 if use_ssl = true
    port = 389
    # Set to true if ldap server supports TLS
    use_ssl = false
    # Set to true if connect ldap server with STARTTLS pattern (create connection in insecure, then upgrade to secure connection with TLS)
    start_tls = false
    # set to true if you want to skip ssl cert validation
    ssl_skip_verify = false
    # set to the path to your root CA certificate or leave unset to use system defaults
    # root_ca_cert = "/path/to/certificate.crt"
    # Authentication against LDAP servers requiring client certificates
    # client_cert = "/path/to/client.crt"
    # client_key = "/path/to/client.key"

    # Search user bind dn
    bind_dn = "grafana@lab.com"
    # Search user bind password
    # If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
    bind_password = 'xxx'

    # User search filter, for example "(cn=%s)" or "(sAMAccountName=%s)" or "(uid=%s)"
    search_filter = "(sAMAccountName=%s)"

    # An array of base dns to search through
    search_base_dns = ["dc=lab,dc=com"]

    ## For Posix or LDAP setups that does not support member_of attribute you can define the below settings
    ## Please check grafana LDAP docs for examples
    # group_search_filter = "(&(objectClass=posixGroup)(memberUid=%s))"
    # group_search_base_dns = ["ou=groups,dc=grafana,dc=org"]
    # group_search_filter_user_attribute = "uid"

    # Specify names of the ldap attributes your ldap uses
    [servers.attributes]
    name = "givenName"
    surname = "sn"
    username = "sAMAccountName"
    member_of = "memberOf"
    email =  "email"

    # Map ldap groups to grafana org roles
    [[servers.group_mappings]]
    #group_dn = "CN=grafana-admin,CN=Users,DC=lab,DC=COM"
    org_role = "Admin"
    # To make user an instance admin  (Grafana Admin) uncomment line below
    # grafana_admin = true
    # The Grafana organization database id, optional, if left out the default org (id 1) will be used
    # org_id = 1

    [[servers.group_mappings]]
    #group_dn = "CN=grafana-editor,CN=Users,DC=lab,DC=COM"
    org_role = "Editor"

    [[servers.group_mappings]]
    # If you want to match all (or no ldap groups) then you can use wildcard
    #group_dn = "*"
    org_role = "Viewer"

metadata:
  labels:
    app: grafana
  name: grafana-config
  namespace: monitoring
```
* Deploy the grafana manifest using the following command.

```bash
kubectl apply -f grafana.yml
```

This will create the following:

**Output:**

```
deployment.extensions/grafana-mon-core created
secret/grafana created
service/grafana created
storageclass.storage.k8s.io/grafana-storage-volume created
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

To get a list of pods in a namespace use the command ` kubectl -n <namespace> get pods`

```bash
kubectl -n monitoring get po
```

**Output:**
```
NAME                                     READY   STATUS    RESTARTS   AGE
grafana-mon-core-7db976d5b9-dlkgw        1/1     Running   0          56s
kube-state-metrics-7c995f7dbd-9zz8q      2/2     Running   0          49s
node-exporter-j6c7f                      1/1     Running   0          52s
node-exporter-lhw72                      1/1     Running   0          52s
prometheus-deployment-5d4b6c8444-85wtx   1/1     Running   0          9m10s

```

**Get list of services**

To get a list of services in a namespace use the command ` kubectl -n <namespace> get svc`
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

To get a list of configmaps in a namespace use the following command

```bash
kubectl -n monitoring get configmaps
```

**Output:**
```
NAME                     DATA   AGE
grafana-config           2      18s
prometheus-server-conf   1      8m41s
```

**Get list of secrets**

To get a list of secrets in a namespace use the command ` kubectl -n <namespace> get secrets`

```bash
kubectl -n monitoring get secrets
```

**Output:**
```
NAME                             TYPE                                  DATA   AGE
default-token-f56sn              kubernetes.io/service-account-token   3      9m45s
grafana                          Opaque                                2      87s
kube-state-metrics-token-c6vq7   kubernetes.io/service-account-token   3      82s
monitoring-token-j62b9           kubernetes.io/service-account-token   3      9m45s

```

**Get list of storage classes**

To get a list of storage classes in a namespace use the command `kubectl -n <namespace> get sc`

```bash
kubectl -n monitoring get  sc
```

**Output:**

```
NAME                        PROVISIONER             AGE
grafana-storage-volume      kubernetes.io/aws-ebs   38s
prometheus-storage-volume   kubernetes.io/aws-ebs   96s
```
**Get list of persistent volumes**

* To get a list of persistent volumes in a namespace use the following command.

```bash
kubectl -n monitoring get pvc
````

**Output:**
```
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                AGE
grafana-pv-claim      Bound    pvc-9e57ea6d-06af-11ea-8c52-12355046b523   50Gi       RWO            grafana-storage-volume      46s
prometheus-pv-claim   Bound    pvc-7707de2f-06ae-11ea-8c52-12355046b523   50Gi       RWO            prometheus-storage-volume   9m2s
```

Forwarding a Local Port to Access the Grafana Service

If you don’t want to expose the Grafana Service externally, you can also forward local port 3000 into the cluster directly to a Grafana Pod using kubectl port-forward.

`kubectl --namespace <namespacename> port-forward  <grafana pod name> 3000`

```bash
kubectl --namespace monitoring port-forward  grafana-mon-core-7db976d5b9-dlkgw   3000
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
This will forward local port 3000 to containerPort 3000 of the Grafana Pod sammy-cluster-monitoring-grafana-0. To learn more about forwarding ports into a Kubernetes cluster, consult Use Port Forwarding to Access Applications in a Cluster.

Visit http://localhost:3000 in your web browser. You should see the following Grafana login page:

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf1.png?st=2019-11-07T09%3A12%3A59Z&se=2022-11-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WjIbH61piaJI8N%2BD5ncfGCP%2FsTWWuSxH%2B45WvzUZKkw%3D" alt="image-alt-text">

To log in, use the default username **admin** and the password **admin**.

You’ll be brought to the following Home Dashboard. Click the **ADD data source**.


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf2.png?st=2019-11-07T09%3A13%3A22Z&se=2022-11-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2v90xqp1uJPzkr2BsVUhxblpE%2BizWEUelcqA7ZGkaRE%3D" alt="image-alt-text">

after clicking the **ADD data source** select the Prometheus.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf3.png?st=2019-11-07T09%3A13%3A49Z&se=2022-11-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UWPmU9TNWPM3xCLl7MmERvlqR%2BFkdE3Q8D%2B6VkLHauE%3D" alt="image-alt-text">

The HTTP protocol, **Prometheus service name** and port of you Prometheus server (default port is usually 9090)

`kubectl-n monitoring get svc`

**Output:**

```
    NAME             TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
prometheus-mon    NodePort      10.0.206.66        <none>        9090:31472/TCP   94s
```

URL:http://prometheus-mon:9090

whitelisted cookies: alerting

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf4.png?st=2019-11-07T09%3A14%3A11Z&se=2022-11-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vCNwIhRrQTG5x2g0DBuDFY0ww0LTk1ih4fs9FUCZoEk%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf5.png?st=2019-11-07T09%3A14%3A43Z&se=2022-11-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HL3xgSCr99t0uyXws6UdO75STHCcWTOGgo7P0b5UbTo%3D" alt="image-alt-text">

* Click on `save & test` should be result Data source is working

In the left-hand navigation bar, select the `Dashboards` button, then click on `Manage`.


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf10.png?st=2019-11-07T09%3A15%3A25Z&se=2022-11-08T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BzOMxgKom4%2BsMAfLWlp9%2FUofBq8TeRQRVXzaVqweKHI%3D" alt="image-alt-text">


**Alerts Linux nodes Dashboard**

In the Grafana.com dashboard input, add the **dashboard ID** we want to use: 5984 and click Load.

On the next screen select a name for your dashboard and select Prometheus as the data source for it and click `Import`.

![](https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/grafana.png?st=2020-02-24T08%3A57%3A46Z&se=2021-02-25T08%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IB3gv3o%2FbI%2B0ihYwB5AI7wc%2F3AwouMXycBx%2B5UZwNV0%3D)

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf7.png?st=2019-11-07T09%3A16%3A07Z&se=2022-11-08T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=E0bViS3emtR2OPRnJ3HbHQ1VYKZJyBBA6uu8WuFl%2FDA%3D" alt="image-alt-text">

These dashboards are generated by Kuberentes-mixin, an open-source project that allows you to create a standardized set of cluster monitoring Grafana dashboards and Prometheus alerts.

* Click in to the Alerts for Linux Nodes, which visualizes CPU, memory, disk, and network usage for a given nodes

* Alerts for Linux Nodes using Prometheus and node_exporter. You can have alerts for Disk space, CPU and Memory. Also added a log of alerts and alert status.

* Right click on **linux Node cpu usage** and edit the query and paste the given query and click `Save` on top right cornor then see the cpu usage of nodes.

`(avg by (instance) (irate(node_cpu_seconds_total{mode="system"}[1m])) * 100)`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf8.png?st=2019-11-07T09%3A17%3A17Z&se=2022-11-08T09%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v8yWnoeH3vPATJL45E6YOwc4GRwHY%2FuRLL8iCYyNjtU%3D" alt="image-alt-text">

![](https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/save.png?st=2020-02-24T09%3A30%3A39Z&se=2021-02-25T09%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y5bsAbMn7yYpMqYGXgRBTgn%2FLPTFEb%2B7YR23DNlxQp4%3D)

**Kubernetes cluster(prometheus)**

In the Grafana.com dashboard input, add the dashboard ID we want to use, click on `import` enter the dashboard id `8739` and click `Load`.

On the next screen select a name for your dashboard and select `Prometheus` as the datasource for it and click `Import`.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/gf11.png?st=2019-11-07T09%3A19%3A31Z&se=2022-11-08T09%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9%2BRCvmO6XVvkiVSOGRIXanvBgacJZT3nMk9nQ9BTXM0%3D" alt="image-alt-text">

* You can check each node usage

![](https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/nodes-graphs.png?st=2020-02-24T09%3A03%3A02Z&se=2021-02-25T09%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aMgoxJfttObUlN%2BOX5qcfciGKT74cw%2Byo0LsycbOfqc%3D)

Simple and straight forward Resource consumption charts for an entire Kubernetes cluster and split per cluster node.

 **Conclusion:** Congratulations! You have successfully completed the OKE cluster monitoring using Prometheus and grafana! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!

## Appendix

### References

 [https://www.digitalocean.com/community/tutorials/how-to-set-up-a-kubernetes-monitoring-stack-with-prometheus-grafana-and-alertmanager-on-digitalocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-kubernetes-monitoring-stack-with-prometheus-grafana-and-alertmanager-on-digitalocean)

 [https://www.8bitmen.com/what-is-grafana-why-use-it-everything-you-should-know-about-it/](https://www.8bitmen.com/what-is-grafana-why-use-it-everything-you-should-know-about-it/)
