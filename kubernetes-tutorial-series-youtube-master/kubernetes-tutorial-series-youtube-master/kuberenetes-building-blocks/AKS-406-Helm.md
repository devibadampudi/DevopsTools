# HELM - The Package Manager for Kubernetes

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Helm Commands Practise](#helm-commands-practise)

[Advanced Helm Charts](#advanced-helm-charts)

## Overview

At the end of this lab, you'll learn Helm and run the commands through the Helm.

* Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

* Charts are easy to create, version, share, and publish — so start using Helm.

* The latest version of Helm is maintained by the [**CNCF**](https://www.cncf.io/) - in collaboration with Microsoft, Google, Bitnami and the Helm contributor community.

**THE PURPOSE OF HELM**

Helm is a tool for managing Kubernetes packages called  _charts_. Helm can do the following:
* Create new charts from scratch
* Package charts into chart archive (tgz) files
* Interact with chart repositories where charts are stored
* Install and uninstall charts into an existing Kubernetes cluster
* Manage the release cycle of charts that have been installed with Helm

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

`kubectl get nodes`

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using this command in Powershell, you get the default namespaces in k8's Cluster

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
## Helm Commands

Helm is a package manager for Kubernetes applications. Helm packages all of the different Kubernetes resources (such as deployments, services, and ingress) into a chart, which may be hosted in a repository. Users can pull down charts and install them on any number of Kubernetes clusters.

Kubernetes can become very complex with all the objects you need to handle ― such as ConfigMaps, services, pods, Persistent Volumes ― in addition to the number of releases you need to manage. These can be managed with Kubernetes Helm, which offers a simple way to package everything into one simple application and advertises what you can configure.

For Helm, there are three important concepts.

1.  The ` _chart_`  is a bundle of information necessary to create an instance of a Kubernetes application.
2.  The  `_config_`  contains configuration information that can be merged into a packaged chart to create a releasable object.
3.  A  `_release_`  is a running instance of a  _chart_, combined with a specific  _config_.

**COMPONENTS**

Helm has two major components.

**Helm Client**  is a command-line client for end users. The client is responsible for the following domains.

-   Local chart development
-   Managing repositories
-   Interacting with the Tiller server
    -   Sending charts to be installed
    -   Asking for information about releases
    -   Requesting upgrading or uninstalling of existing releases

**Tiller Server**  is an in-cluster server that interacts with the Helm client, and interfaces with the Kubernetes API server. The server is responsible for the following:

-   Listening for incoming requests from the Helm client
-   Combining a chart and configuration to build a release
-   Installing charts into Kubernetes, and then tracking the subsequent release
-   Upgrading and uninstalling charts by interacting with Kubernetes

* Helm client is installed in lab console has part of the lab, to verify the helm client version, run the following command. This command should gives you only client version

```bash
helm version
```
**Output:**
```
Client: &version.Version{SemVer:"v2.13.1", GitCommit:"618447cbf203d147601b4b9bd7f8c37a5d39fbb4", GitTreeState:"clean"}
Error: Get https://kubernetes.docker.internal:6443/api/v1/namespaces/kube-system/pods?labelSelector=app%3Dhelm%2Cname%3Dtiller: EOF
```

### Installing Tiller

Tiller, the server portion of Helm, typically runs inside of your Kubernetes cluster. But for development, it can also be run locally, and configured to talk to a remote Kubernetes cluster.

**Note:** Most cloud providers use a feature Role-Based Access Control(RBAC), needs to create a ServiceAccount to create Tiller with right roles and permission to access resources.

* The easiest way to install Tiller in-kubernetes cluster is by simply running the following command

* This command creates your `~/.helm`  and deploys (via a Kubernetes Deployment ) Tiller  to your Kubernetes cluster.

```bash
helm init
```

**Output:**
```
Creating C:\Users\sysgain\.helm
Creating C:\Users\sysgain\.helm\repository
Creating C:\Users\sysgain\.helm\repository\cache
Creating C:\Users\sysgain\.helm\repository\local
Creating C:\Users\sysgain\.helm\plugins
Creating C:\Users\sysgain\.helm\starters
Creating C:\Users\sysgain\.helm\cache\archive
Creating C:\Users\sysgain\.helm\repository\repositories.yaml
Adding stable repo with URL: https://kubernetes-charts.storage.googleapis.com
Adding local repo with URL: http://127.0.0.1:8879/charts
$HELM_HOME has been configured at C:\Users\sysgain\.helm.
Warning: Tiller is already installed in the cluster.
(Use --client-only to suppress this message, or --upgrade to upgrade Tiller to the current version.)
Happy Helming!
```

* Once Tiller installation has done `helm init`, Tiller installs in the `kube-system` namespace.

* Verify the Tiller installed on the cluster using the following command.

```bash
kubectl -n kube-system get po
```

**Output:**
```
NAME                                    READY     STATUS    RESTARTS   AGE
tiller-deploy-645669f4cd-c2wbr          1/1       Running   0          1
```

* Once Tiller is installed on Kubernetes cluster, run the following command to check the version. Result shows both client and server versions

```bash
helm version
```

**Output:**

```
Client: &version.Version{SemVer:"v2.13.1", GitCommit:"618447cbf203d147601b4b9bd7f8c37a5d39fbb4", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.14.0", GitCommit:"05811b84a3f93603dd6c2fcfe57944dfa7ab7fd0", GitTreeState:"clean"}
```

### Upgrading Tiller

*  Use the following command to upgrade Tiller.

`helm init --upgrade`

**Output:**
```
$HELM_HOME has been configured at C:\Users\sysgain\.helm.

Tiller (the Helm server-side component) has been upgraded to the current version.
Happy Helming!
```

## Helm Commands Practise

### Install a Helm chart

* To install a chart, run the helm install command, Helm has multiple ways to find and install a chart, but the simplest way to use official `stable` charts.

* `helm search` command will show you list of all charts in the `stable`  repository.

```bash
helm search
```

**Output:**
```
stable/tomcat                           0.2.0           7                               Deploy a basic tomcat application server with sidecar as ...
stable/traefik                          1.73.1          1.7.12                          A Traefik based Kubernetes ingress controller with Let's ...
stable/uchiwa                           1.0.0           0.22                            Dashboard for the Sensu monitoring framework
stable/unbound                          1.0.0           1.6.7                           Unbound is a fast caching DNS resolver
stable/unifi                            0.4.2           5.10.19                         Ubiquiti Network's Unifi Controller
stable/vault-operator                   0.1.1           0.1.9                           CoreOS vault-operator Helm chart for Kubernetes
stable/velero                           2.1.1           1.0.0                           A Helm chart for velero
```

* Run the `helm repo update` command, Update gets the latest information about charts from the respective chart repositories.

```bash
helm repo update
```

**Output:**
```
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
```

* Helm installs the `Tiller` service on your cluster to manage charts. We will need to use kubectl to create a `ServiceAccount` and `clusterrolebinding` so tiller has permission to deploy to the cluster.

* Create the `ServiceAccount` in the `kube-system` namespace.

* Execute the following commands to enable RBAC permissions

```bash
kubectl --namespace kube-system create serviceaccount tiller
```
**Output:**
```
serviceaccount/tiller created
```
**Note:** "Error from server serviceaccount tiller already exists" message is coming while executing the below command. Ignore this Information if you get like this

* Create the `ClusterRoleBinding` to give the `Tiller` account access to the cluster.

```bash
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
```

**Output:**
```
clusterrolebinding.rbac.authorization.k8s.io/tiller created
```
**Note:** Error from server clusterrolebindings.rbac.authorization.k8s.io tiller already exists. Ignore this Information if you get like this

* Finally use Helm to install the `Tiller` service.

```bash
helm init --service-account tiller --upgrade
```
**Note:** Error from server serviceaccount tiller already exists" message is coming while executing the below command. Ignore this information if you gets like this.

**Output:**
```
$HELM_HOME has been configured at C:\Users\sysgain\.helm.
Tiller (the Helm server-side component) has been upgraded to the current version.
Happy Helming!
```

* Run the following command to chart creates a Tomcat application server deployment.

### Installing the Chart

* Tomcat chart creates a tomcat application server Deployment, plus http Services for the server.

* To install the chart with the release name `test-release`, run the following commmand as shown below.

```bash
helm install --name test-release stable/tomcat
```

**Output:** 
```
NAME:   test-release
LAST DEPLOYED: Tue Nov 19 15:56:09 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Deployment
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
test-release-tomcat  0/1    0           0          1s

==> v1/Pod(related)
NAME                                  READY  STATUS    RESTARTS  AGE
test-release-tomcat-659fb7dc54-b87lm  0/1    Init:0/1  0         1s

==> v1/Service
NAME                 TYPE          CLUSTER-IP     EXTERNAL-IP  PORT(S)       AGE
test-release-tomcat  LoadBalancer  10.96.230.184  localhost    80:32439/TCP  1s


NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get svc -w test-release-tomcat'
  export SERVICE_IP=$(kubectl get svc --namespace default test-release-tomcat -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  echo http://$SERVICE_IP:

```

### Get the Services, Pods and Deployments

* Use the following commands to listout the resources as deployed from the `helm install` command.

```bash
kubectl get svc
```

**Output:**
```
NAME                    TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
test-release-tomcat   LoadBalancer   10.96.151.57   150.136.159.116   80:32367/TCP   3m42s
```
* Get the pods using the following command.

```bash
kubectl get pods
```

**Output:**
```
NAME                                     READY     STATUS    RESTARTS   AGE
test-release-tomcat-67b594444b-rbfzn   1/1     Running   0          5m38s
```

```bash
kubectl get deploy
```

**Output:**
```
NAME                  DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
test-release-tomcat   1         1         1            1           7m30s
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/MicrosoftTeams-image%20(3).png?st=2019-11-26T18%3A09%3A03Z&se=2021-11-27T18%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=exWGsRJB4HE6Ptr6%2Fhf17ys%2Bl%2F3Dz2PAe1fcv7bs1xg%3D" alt="image-alt-text" >

### Helm list-out all release of charts in the kubernetes cluster.

* Run the following command to list Helm charts releases

```bash
helm ls
```

**Output:**
```
NAME            REVISION        UPDATED                         STATUS          CHART           APP VERSION     NAMESPACE
test-release    1               Tue Nov 19 16:43:32 2019        DEPLOYED        tomcat-0.4.0    7.0             default
```

### Status of Helm Release

* Run the following command to view the status of Helm release.

```bash
helm status test-release
```

**Output:**
```
LAST DEPLOYED: Tue Nov 19 16:43:32 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Deployment
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
test-release-tomcat  1/1    1           1          21m

==> v1/Pod(related)
NAME                                  READY  STATUS   RESTARTS  AGE
test-release-tomcat-67b594444b-kzdmw  1/1    Running  0         21m

==> v1/Service
NAME                 TYPE          CLUSTER-IP   EXTERNAL-IP     PORT(S)       AGE
test-release-tomcat  LoadBalancer  10.96.74.96  150.136.204.43  80:31401/TCP  21m


NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get svc -w test-release-tomcat'
  export SERVICE_IP=$(kubectl get svc --namespace default test-release-tomcat -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  echo http://$SERVICE_IP:
```

### List Release Numbers

* `helm history` command, prints historical revisions for a given release.

```bash
helm history  test-release
```

**Output:**
```
REVISION        UPDATED                         STATUS  CHART           DESCRIPTION
1               Tue Nov 19 16:43:32 2019        DELETED tomcat-0.4.0    Deletion complete
```

**Helm GET**

* `helm get` command gives a following details about the named release.
* The values used to generate the release
* The chart used to generate the release
* The generated manifest file

```bash
helm get test-release
```

**Output:**
```
 REVISION: 1
RELEASED: Tue Nov 19 17:21:26 2019
CHART: tomcat-0.4.0
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
affinity: {}
deploy:
  directory: /usr/local/tomcat/webapps
env: []
extraInitContainers: []
extraVolumeMounts: []
extraVolumes: []
hostPort: 8009
image:
  pullPolicy: IfNotPresent
  pullSecrets: []
  tomcat:
    repository: tomcat
    tag: "7.0"
  webarchive:
    repository: ananwaresystems/webarchive
    tag: "1.0"
ingress:
  annotations: {}
  enabled: false
  hosts:
  - chart-example.local
  path: /
  tls: []
livenessProbe:
  initialDelaySeconds: 60
  path: /sample
  periodSeconds: 30
nodeSelector: {}
readinessProbe:
  failureThreshold: 6
  initialDelaySeconds: 60
  path: /sample
  periodSeconds: 30
replicaCount: 1
resources: {}
service:
  externalPort: 80
  internalPort: 8080
  name: http
  type: LoadBalancer
tolerations: []

HOOKS:
MANIFEST:

---
# Source: tomcat/templates/appsrv-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: test-release-tomcat
  labels:
    app: tomcat
    chart: tomcat-0.4.0
    release: test-release
    heritage: Tiller
spec:
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
      name: http
  selector:
    app: tomcat
    release: test-release
---
# Source: tomcat/templates/appsrv.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-release-tomcat
  labels:
    app: tomcat
    chart: tomcat-0.4.0
    release: test-release
    heritage: Tiller
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tomcat
      release: test-release
  template:
    metadata:
      labels:
        app: tomcat
        release: test-release
    spec:
      volumes:
        - name: app-volume
          emptyDir: {}
      initContainers:
        - name: war
          image: ananwaresystems/webarchive:1.0
          imagePullPolicy: IfNotPresent
          command:
            - "sh"
            - "-c"
            - "cp /*.war /app"
          volumeMounts:
            - name: app-volume
              mountPath: /app

      containers:
        - name: tomcat
          image: tomcat:7.0
          imagePullPolicy: IfNotPresent
          volumeMounts:
            - name: app-volume
              mountPath: /usr/local/tomcat/webapps
          ports:
            - containerPort: 8080
              hostPort: 8009
          livenessProbe:
            httpGet:
              path: /sample
              port: 8080
            initialDelaySeconds: 60
            periodSeconds: 30
          readinessProbe:
            httpGet:
              path: /sample
              port: 8080
            initialDelaySeconds: 60
            periodSeconds: 30
            failureThreshold: 6
          resources:
            {}
```

* View each resources output as yaml, use the following command to get more information about services, deployments and pods.

### Get a service output as yaml output

```bash
kubectl get svc test-release-tomcat -o yaml
```

**Output:**
```
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2019-11-19T11:51:26Z"
  labels:
    app: tomcat
    chart: tomcat-0.4.0
    heritage: Tiller
    release: test-release
  name: test-release-tomcat
  namespace: default
  resourceVersion: "7339"
  selfLink: /api/v1/namespaces/default/services/test-release-tomcat
  uid: eadb98d4-0ac2-11ea-836d-0a580aeddfc7
spec:
  clusterIP: 10.96.151.57
  externalTrafficPolicy: Cluster
  ports:
  - name: http
    nodePort: 32367
    port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: tomcat
    release: test-release
  sessionAffinity: None
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
    - ip: 150.136.159.116
```

### Get a deployment as yaml output

```bash
kubectl get deploy test-release-tomcat -o yaml
```

**Output:**
``` 
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2019-11-19T11:51:26Z"
  generation: 1
  labels:
    app: tomcat
    chart: tomcat-0.4.0
    heritage: Tiller
    release: test-release
  name: test-release-tomcat
  namespace: default
  resourceVersion: "7423"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/test-release-tomcat
  uid: eade71b9-0ac2-11ea-836d-0a580aeddfc7
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: tomcat
      release: test-release
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: tomcat
        release: test-release
    spec:
      containers:
      - image: tomcat:7.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          failureThreshold: 3
          httpGet:
            path: /sample
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 60
          periodSeconds: 30
          successThreshold: 1
          timeoutSeconds: 1
        name: tomcat
        ports:
        - containerPort: 8080
          hostPort: 8009
          protocol: TCP
        readinessProbe:
          failureThreshold: 6
          httpGet:
            path: /sample
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 60
          periodSeconds: 30
          successThreshold: 1
          timeoutSeconds: 1
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /usr/local/tomcat/webapps
          name: app-volume
      dnsPolicy: ClusterFirst
      initContainers:
      - command:
        - sh
        - -c
        - cp /*.war /app
        image: ananwaresystems/webarchive:1.0
        imagePullPolicy: IfNotPresent
        name: war
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /app
          name: app-volume
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - emptyDir: {}
        name: app-volume
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2019-11-19T11:52:44Z"
    lastUpdateTime: "2019-11-19T11:52:44Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2019-11-19T11:51:26Z"
    lastUpdateTime: "2019-11-19T11:52:44Z"
    message: ReplicaSet "test-release-tomcat-67b594444b" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
```

### Get a pod as yaml

```bash
kubectl get pods test-release-tomcat-67b594444b-rbfzn -o yaml
```

**Output:**
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2019-11-19T11:51:26Z"
  generateName: test-release-tomcat-67b594444b-
  labels:
    app: tomcat
    pod-template-hash: 67b594444b
    release: test-release
  name: test-release-tomcat-67b594444b-rbfzn
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: test-release-tomcat-67b594444b
    uid: eadf9bab-0ac2-11ea-836d-0a580aeddfc7
  resourceVersion: "7420"
  selfLink: /api/v1/namespaces/default/pods/test-release-tomcat-67b594444b-rbfzn
  uid: eae1aa02-0ac2-11ea-836d-0a580aeddfc7
spec:
  containers:
  - image: tomcat:7.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 3
      httpGet:
        path: /sample
        port: 8080
        scheme: HTTP
      initialDelaySeconds: 60
      periodSeconds: 30
      successThreshold: 1
      timeoutSeconds: 1
    name: tomcat
    ports:
    - containerPort: 8080
      hostPort: 8009
      protocol: TCP
    readinessProbe:
      failureThreshold: 6
      httpGet:
        path: /sample
        port: 8080
        scheme: HTTP
      initialDelaySeconds: 60
      periodSeconds: 30
      successThreshold: 1
      timeoutSeconds: 1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /usr/local/tomcat/webapps
      name: app-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-qbwdx
      readOnly: true
  dnsPolicy: ClusterFirst
  initContainers:
  - command:
    - sh
    - -c
    - cp /*.war /app
    image: ananwaresystems/webarchive:1.0
    imagePullPolicy: IfNotPresent
    name: war
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /app
      name: app-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-qbwdx
      readOnly: true
  nodeName: 10.0.1.2
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - emptyDir: {}
    name: app-volume
  - name: default-token-qbwdx
    secret:
      defaultMode: 420
      secretName: default-token-qbwdx
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2019-11-19T11:51:28Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2019-11-19T11:52:44Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2019-11-19T11:52:44Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2019-11-19T11:51:26Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://34579872fa5eb2214297dea71d125987841f884985073dfd39dccc19cf8e74cd
    image: tomcat:7.0
    imageID: docker-pullable://tomcat@sha256:9b9b01f50a953d3fe24e78404c66cae3372b446d5b162f42c1c64da7e2ec3f51
    lastState: {}
    name: tomcat
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: "2019-11-19T11:51:28Z"
  hostIP: 10.0.1.2
  initContainerStatuses:
  - containerID: docker://289ec0182047b43d7b0ff1d362ee079997ce5a224da839629a4add5ba86eedd3
    image: ananwaresystems/webarchive:1.0
    imageID: docker-pullable://ananwaresystems/webarchive@sha256:47968a7c355df59f14ef5407a0a26851d206e78add96ce4c2f48a214eb5d2b6c
    lastState: {}
    name: war
    ready: true
    restartCount: 0
    state:
      terminated:
        containerID: docker://289ec0182047b43d7b0ff1d362ee079997ce5a224da839629a4add5ba86eedd3
        exitCode: 0
        finishedAt: "2019-11-19T11:51:28Z"
        reason: Completed
        startedAt: "2019-11-19T11:51:28Z"
  phase: Running
  podIP: 10.244.1.4
  qosClass: BestEffort
  startTime: "2019-11-19T11:51:26Z"
```

**Helm Fetch**

* Get the packages from the repository and then unpack it locally.

```bash
helm fetch stable/mysql
```
* Run `ls` command to display the packed charts in a directory.

**Output:**
```
-a----       11/19/2019   5:44 PM          10657 mysql-1.4.0.tgz
```
* Run `helm fetch stable/tomcat` command to grab the chart from the chart repository and downloaded to locally

```bash
helm fetch stable/tomcat
```

* Downloaded locally when you runs the `helm fetch` command. verify by using `ls` command to dispaly the files

**Output:**
```
tomcat-0.2.0.tgz
```
* Adding a repository to your workspace local repository list.

**Repository** Storage for Helm charts. The namespace of the hub for official charts is `stable`. Helm chart repositories a chart repository is a location where packaged charts can be stored and shared.

* The official chart repository is maintained by the [Kubernetes Charts](https://github.com/helm/charts)

* When you are ready to share your charts, simply let someone know what the URL of your repository is and they will add the repository to helm client via the `helm repo add`

E.g. helm repo add <url-of-chart>

```bash
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.3.2/charts/
```

**Output:**
```
"istio.io" has been added to your repositories
```

* List the repositories using the following command.

```
helm repo list
```

**Output:**
```
NAME            URL
stable          https://kubernetes-charts.storage.googleapis.com
local           http://127.0.0.1:8879/charts
istio.io        https://storage.googleapis.com/istio-release/releases/1.3.2/charts/
```

* After you have updated the repository, can use the `helm repo update` command to get the latest chart information. Update list of Helm charts from repositories

```bash
helm repo update
```

**Output:**
```
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "istio.io" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
```
### Unistall a Release

* To unistall a release use `helm delete` command to delete release.

```bash
helm delete test-release
```

**Output:**
```
release "test-release" deleted
```

* `helm ls --deleted` command will shows deleted helm charts.

```
helm ls --deleted 
```

**Output:**
```
NAME            REVISION        UPDATED                         STATUS  CHART           APP VERSION NAMESPACE
test-release    1               Tue Nov 19 16:43:32 2019        DELETED tomcat-0.4.0    7.0         default
```

* `helm ls --all` command will shows all deployed and deleted charts, verify using the `Status`

```
NAME            REVISION        UPDATED                         STATUS  CHART           APP VERSION NAMESPACE
test-release    1               Tue Nov 19 16:43:32 2019        DELETED tomcat-0.4.0    7.0         default
```

## Helm Purge

* When you try to do helm delete $RELEASE_NAME it deletes all resources but keeps the information with $RELEASE_NAME in case you want to rollback. 
* You can see removed releases via `helm ls -a`,Whereas `helm delete --purge test-release` removes records and make that name free to be reused for another installation.

```bash
helm ls -a
```

**Output:**
```
NAME            REVISION        UPDATED                         STATUS  CHART           APP VERSION NAMESPACE
test-release    1               Tue Nov 19 16:43:32 2019        DELETED tomcat-0.4.0    7.0         default      
```

```bash
helm delete --purge test-release
```

**Output:**
```
release "test-release" deleted
```
* Show all releases, not just the ones marked `DEPLOYED`, use the following command

```bash
helm ls -a
```
* Output displays nothing because everything is purged.

## Advanced Helm Charts

#### Create a helm charts for microservices

### Helm Create:

* Helm create will creates a new chart with specified name. Chart names should use lower case letters and numbers, and start with a letter.

* Hyphens (-) are allowed, but are known to be a little trickier to work with in Helm templates

* This will create a chart directory along with the files and directories used in chart, The following command creates a chart directory.

```bash
helm create test-sample
```

**Output:**
```
Creating test-sample
```

* cd to `test-sample` directory.

```bash
cd .\test-sample\
```
* Run the `ls` command view the files/folders in a directory.

```bash
ls
```

**Output:**

```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        7/25/2019   3:37 PM                charts
d-----        7/25/2019   3:37 PM                templates
-a----        7/25/2019   3:37 PM            342 .helmignore
-a----        7/25/2019   3:37 PM            107 Chart.yaml
-a----        7/25/2019   3:37 PM           1082 values.yaml
```

* `helm create` a path as mentioned previous argument, if directory in the specified path do not exist, Helm will create them as it goes. If the directory in the specified path exists, conflict files will be overwritten remaining files will be left alone.

* Use the `test-samples` directory to customize the helm charts. Run `ls` command to list-out the available folders/files in a directory.

```
ls
```
A chart is organized as a collection of files inside of a directory. The directory name is the name of the chart (without versioning information). Thus, a chart describing test-samples would be stored in the `test-samples/` directory.

**FORMATTING YAML**

YAML files should be indented using two spaces (and never tabs).

Inside of this directory, Helm will expect a structure that matches this

**Output:**
```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/19/2019   3:49 PM                charts # A directory containing any charts upon which this chart depends.
d-----       11/19/2019   3:49 PM                templates # A directory of templates that, when combined with values, will generate valid Kubernetes manifest files.
-a----       11/19/2019   3:49 PM            342 .helmignore 
-a----       11/19/2019   3:49 PM            107 Chart.yaml # A YAML file containing information about the chart
-a----       11/19/2019   3:49 PM           1082 values.yaml # The default configuration values for this chart
```

* In this part of the lab, we provide recommendations on how you should structure and use your values, with focus on designing a chart’s `values.yaml` file.

**Naming Conventions:**

* Variables names should begin with a lowercase letter, and words should be separated with camelcase, as shown below

```
test: true
testApplication: true
```
* Note that all of Helm’s built-in variables begin with an uppercase letter to easily distinguish them from user-defined values.

**FLAT OR NESTED VALUES**

* YAML is a flexible format, and values may be nested deeply or flattened.

**Nested:**

```
server:
  name: nginx
  port: 80
```
**Flat**
```
serverName: nginx
serverPort: 80
```

**Templates**

The most important piece of the charts is the templates/ directory. This is where Helm finds the YAML manifests for Services,Deployments and other Kubernetes objects you are going to mention it.

Basically in templates directory will gives deafult syntaxes, and Helm runs each file in this directory through a Go template rendering engine. Helm extends the template language, adding a number of utility functions for writing charts. Open the service.yaml file

* Add requires configuration to services, deployments and ingresses to yaml file.



* Customize Helm charts using the following configuration. 

* Defined templates (templates created inside a `{{ define }}` directive) are globally accessible. That means that a chart and all of its sub charts will have access to all of the templates created with {{ define }}.

**FORMATTING TEMPLATES**

* Templates should be indented using two spaces (never tabs).

* Template directives should have whitespace after the opening braces and before the closing braces like these `{{ print "foo" }}`

**RESOURCE NAMING IN TEMPLATES**

Hard-coding the `name:` into a resource is usually considered to be bad practice. Names should be unique to a release. So we might want to generate a name field by inserting the release name - for example.
* Here we are assigning `$key` and `$value` to `.Values.microservices` which is specified in values.yaml, here $key will take 
* `range` function which provides a `for-each` style loop,The range function will range over (iterate through) the microServices list, variables are assigned with a special assignment operator: `:=`

```
{{ if .Values.microServices }}
{{- range $key, $value := .Values.microServices }}
apiVersion: v1
kind: Service
metadata:
  name: {{ $key }}
```
**COMMENTS (YAML COMMENTS VS. TEMPLATE COMMENTS)**

* Both YAML and Helm Templates have comment markers.

**YAML comments:**

```
# This is a comment
type: test
```
**Template Comments**

```
{{- /*
This is a comment.
*/ -}}
```
* In Helm there is one variable that is always global `- $ -` this variable will always point to the root context. This can be very useful when you are looping in a range and need to know the chart’s release name.

* In Helm templates, a variable is a named reference to another object

* cd to `templates` directory & run the command `notepad .\service.yaml` which will open up a notepad, remove the default configuration and copy the below configuration code paste it in `service.yaml` and save it.

* Service-file definition.

```yaml
{{ if .Values.microServices }} # for creating conditional blocks
{{- range $key, $value := .Values.microServices }} #range function which provides a for-each style loop,The range function will range over (iterate through) the microServices list, variables are assigned with a special assignment operator: `:=` here $key and $value variable points to .Values.microServices

apiVersion: v1
kind: Service
metadata:
  name: {{ $key }}
  labels:
    service-name: {{ $key }}
spec:
  type: {{ $.Values.service.type }} # Here $.Values.service.type access the top level variables fetch the values from the values.yaml
  ports:
    - port: {{ $value.svcPort }} # fetch values from the $value which is .Values.microServices list
      targetPort: {{ $value.containerPort }} #fetch values from the $value which is .Values.microServices list
      protocol: TCP
      name: http
  selector:
    service-name: {{ $key }}

---
{{- end }}
{{ end }}

```
* Basic Deployment configuration file generated, while you creation of charts, change according to `Values.yaml` variables and declare them in a deployment-file.

* Run the command `notepad .\deployment.yaml` which will open up a notepad, remove the default configuration and copy the below configuration code paste it in `deployment.yaml` and save it.

```yaml
{{ if .Values.microServices }}
{{- range $key, $value := .Values.microServices }}
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: {{ $key }}
  labels:
    service-name: {{ $key }}
spec:
  replicas: {{ $.Values.replicaCount }}  # Here $.Values.replicaCount access the top level variables fetch the values from the values.yaml
  selector:
    matchLabels:
      service-name: {{ $key }}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        service-name: {{ $key }}
    spec:
      containers:
        - name: {{ $key }}
          image: "{{ $.Values.image.repository }}:{{ $value.imageTag }}" # Here $.Values.image.repository access the top level variables fetch the values from the values.yaml and $value.imageTag comes from the .Values.microServices list
          imagePullPolicy: {{ $.Values.image.pullPolicy }} # Here $.Values.image.pullPolicy access the top level variables fetch the values from the values.yaml
          # livenessProbe:
          #   failureThreshold: 3
          #   httpGet:
          #     path: /v2/components/{{ $value.swaggerPhrase }}/swagger
          #     port: 7075
          #     scheme: HTTP
          #   initialDelaySeconds: 30
          #   periodSeconds: 100
          #   successThreshold: 1
          #   timeoutSeconds: 1  
          # readinessProbe:
          #   failureThreshold: 3
          #   httpGet:
          #     path: /v2/components/{{ $value.swaggerPhrase }}/swagger
          #     port: 7075
          #     scheme: HTTP
          #   periodSeconds: 100
          #   successThreshold: 1
          #   timeoutSeconds: 1
          ports:
            - containerPort: {{ $value.containerPort }} # here $value.containerPort comes from the .Values.microServices list
---
{{- end }}
{{ end }}
```
* This is a basic service and deployment definition using template files. When deploying the chart, Helm will generate a definition that will look a lot more like a valid Service. Can do a `dry-run` of a helm install and enable debug to inspect the generated definitions.

* Go to two directories up using the following command.

```bash
cd ../..
```
**Note:** While running `helm install --dry-run` you should not inside a `test-sample` directory.

```bash
helm install --dry-run --debug test-sample
```

**Values**

The template in service.yaml makes use of the Helm-specific objects .Chart and .Values.. The former provides metadata about the chart to your definitions such as the name, or version. The latter .Values object is a key element of Helm charts, used to expose configuration that can be set at the time of deployment. The defaults for this object are defined in the values.yaml file. Try changing the default value for service.internalPort and execute another dry-run, you should find that the targetPort in the Service and the containerPort in the Deployment changes

* If you want to change the default configuration, they could provide overrides directly on the command-line.

```bash
helm install --dry-run --debug ./test-sample --set service.internalPort=8080
```

* Move as many variables out of your template and into the `values.yaml` and then use for further configuration. Change `Values.yaml` to add more configurations to your application.

* Change to test-sample directory using the command `cd test-sample`, content of the `values.yaml` is an arbitrary YAML structure, which you can define however you want to define customize

* Run the command `notepad .\values.yaml`, remove the default configuration, copy the below configuration code paste it in `values.yaml` and save it.

```yaml
# Default values for test.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: sysgaininc/vote-front # stored docker images in this repository for services used in this configuration
  tag: stable
  pullPolicy: Always

nameOverride: ""
fullnameOverride: ""

service:
  type: ClusterIP # service type providing cluster ip service

ingress:
  enabled: false
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: chart-example.local
      paths: []

  tls: []
  #  - secretName: chart-example-tls
  #    hosts:
  #      - chart-example.local

resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
  #   memory: 128Mi
nodeSelector: {}

tolerations: []

affinity: {}

microServices: 
  db:
    containerPort: 5432
    svcPort: 5432
    imageTag: postgres
    needsIngress: true
  redis:
    containerPort: 6379
    svcPort: 6379
    imageTag: redis
    needsIngress: true
  result:
    containerPort: 80
    svcPort: 5001
    imageTag: result
  vote:
    containerPort: 80
    svcPort: 5000
    imageTag: vote
```

* Want to see output before it is installed to ensure things look correct? run the following command.

* When you want to test the template rendering, but not actually install anything, you can use the following command.

**Note:** While running `helm install --dry-run` you should not inside a `test-sample` directory.

```bash
helm install --dry-run --namespace test --debug test-sample
```

* Deploy the charts to kubernetes use the following command

**Note:** While running `helm install` you should not inside a `test-sample` directory.

```bash
helm install --name sample-chart test-sample --namespace test 
```

**Output:**
```
NAME:   sample-chart
LAST DEPLOYED: Tue Nov 19 20:56:01 2019
NAMESPACE: test
STATUS: DEPLOYED

RESOURCES:
==> v1/Pod(related)
NAME                     READY  STATUS             RESTARTS  AGE
db-67898d55c-ljsbw       0/1    ContainerCreating  0         2s
redis-777d4bf8d-z74pk    0/1    ContainerCreating  0         2s
result-68dfc95c87-xd4bq  0/1    ContainerCreating  0         2s
vote-7dc748ddcb-rcb6w    0/1    ContainerCreating  0         2s

==> v1/Service
NAME    TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)   AGE
db      ClusterIP  10.96.9.130    <none>       5432/TCP  2s
redis   ClusterIP  10.96.1.222    <none>       6379/TCP  2s
result  ClusterIP  10.96.240.46   <none>       5001/TCP  2s
vote    ClusterIP  10.96.108.229  <none>       5000/TCP  2s

==> v1beta2/Deployment
NAME    READY  UP-TO-DATE  AVAILABLE  AGE
db      0/1    1           0          2s
redis   0/1    1           0          2s
result  0/1    1           0          2s
vote    0/1    1           0          2s

NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace test -l "app.kubernetes.io/name=test-sample,app.kubernetes.io/instance=sample-chart" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward $POD_NAME 8080:80
```

* Get the pods and services using the following commands.

```bash
kubectl -n test get pods
```

**Output:**
```
NAME                      READY   STATUS    RESTARTS   AGE
db-67898d55c-ljsbw        1/1     Running   0          49m
redis-777d4bf8d-z74pk     1/1     Running   0          49m
result-68dfc95c87-xd4bq   1/1     Running   0          49m
vote-7dc748ddcb-rcb6w     1/1     Running   0          49m
```

```bash
 kubectl -n test get svc
```

**Output:**
```
NAME     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
db       ClusterIP   10.96.9.130     <none>        5432/TCP   59m
redis    ClusterIP   10.96.1.222     <none>        6379/TCP   59m
result   ClusterIP   10.96.240.46    <none>        5001/TCP   59m
vote     ClusterIP   10.96.108.229   <none>        5000/TCP   59m
```

* Access the application using the `port-forward`

```bash
kubectl -n test port-forward svc/result 5001
```
**Output:**
```
Forwarding from 127.0.0.1:5001 -> 80
Forwarding from [::1]:5001 -> 80
```
* Hit `localhost:5001` on browser, you will be access to the application as shown below.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/helm-vote.PNG?st=2019-11-19T16%3A59%3A02Z&se=2021-11-20T16%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q%2BlcW%2FYM%2BjMo8DfnKMkx54LI222wxnxdaOCti1B%2FifI%3D" alt="image-alt-text" >

* To delete and reinstall the Helm chart at any time, use the helm delete command, shown below. The additional `--purge` option removes the release name from the store so that it can be reused later.

```bash
 helm delete --purge sample-chart
```

**Output:**
```
release "sample-chart" deleted
```
References:
1. https://helm.sh/docs/helm/

**Conclusion:** Congratulations! You have successfully completed the Helm lab. In this lab explored Helm charts using Helm commands!

Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab
