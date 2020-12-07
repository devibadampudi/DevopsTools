# Creation of VPC with AWS Management console
## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites) 

[Creation of VPC using AWS management console](#creation-of-vpc-using-aws-management-console)


## Overview

The Aim of this lab is about create an VPC with IPv4 CIDR block using the Aws Management console

## Pre-requisites
 
 None Required

## Creation of VPC using AWS management console

* Before creation of VPC you need to authenticate with the AWS console, Navigate to the chrome-browser, sign-in to the Aws management console from the following url.

`https://console.aws.amazon.com`

* Credentials will be provided here, copy these information and paste corresponding values in the AWS Management console.

* Account ID: {{Account ID}}
* user name: {{user name}}
* password: {{password}}
* region: {{region}}

* Mention account-id from the above information, then click on `Next`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

* Mention Username and password from the above information

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

* Once you were provided all those information correctly you will be able to see the AWS-managemnt console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >

* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

* Create a VPC CIDR with AWS management console

* Navigate to services and search `vpc` you will get the bunch of services provided by aws.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/search-vpc-console.png?st=2019-09-09T09%3A56%3A29Z&se=2022-09-10T09%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oDPFRNes2Z4RkzLSHJZqkF%2BfcnXY0LTxaMtmZsTa9sc%3D" alt="image-alt-text" >

* Choose either `VPCs` or `your VPCs`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/creation-of-vpc-console.png?st=2019-09-09T09%3A57%3A59Z&se=2022-09-10T09%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rn528u7g8kfMMLJzIOsQKNs77fSDqgqIrozOo6IufnE%3D" alt="image-alt-text" >

* Choose `Create VPC` button to create a vpc

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/creation-of-vpc-console1.png?st=2019-09-09T09%3A59%3A16Z&se=2022-09-10T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7GS9OsvlIRgOmqqWHKhQyPO99BLdPApWv%2F4s%2BJaFDk4%3D" alt="image-alt-text" >

* Provide name of VPC and /16 IPv4 CIDR block (e.g.10.0.0.0/16) and then click-on create button this will creates a VPC

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/creation-of-vpc-console2.png?st=2019-09-09T09%3A59%3A44Z&se=2022-09-10T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xszbLm5j%2BjZiLPvoc%2FSX3L1dTU9Xz9d7XzXaK1G3xrs%3D" alt="image-alt-text" >


* Congratulations successfully deployed VPC with CIDR using AWS Management console.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/congrats-gif.gif?st=2019-09-09T10%3A10%3A06Z&se=2022-09-10T10%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=t2rAJpDUEoJ4DM5rI1GxeCgvgjq6MwQGjkv%2FukiiK%2Bk%3D" alt="image-alt-text" >
