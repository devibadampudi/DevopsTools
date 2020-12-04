# Terraform AWS

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Set Up Terraform Provider For AWS](#set-up-terraform-provider-for-aws)

[Create And Deploy A Virtual Private Cloud Using Terraform](#create-and-deploy-a-virtual-private-cloud-using-terraform)

[Create EC2 Instance And Related Resources Using Terraform](#create-ec2-instance-and-related-resources-using-terraform)

[Install Apache Using Terraform](#Install-apache-using-terraform)

## Overview

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON.

Use this Infrastructure as Code tool to provision and manage any cloud, infrastructure, or service. You define the Configuration files to manage the full lifecycle — create new resources, manage existing ones, and destroy those no longer needed.

## Pre-Requisites

  1. Familiarity with AWS console

  2. Overview of resources that are required to launch an EC2 instance.

  3. Connecting to a EC2 instance.

## Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on `My Account` and in the dropdown, select `AWS Management console`.

3. Use below credentials to login to AWS console.

    * Account ID: {{Account ID}}
    * IAM username: {{user name}}
    * Password: {{password}}
    * Region: {{region}}
    
    Make sure to pass region as us-west-2 if it is **oregon**.if it is **ohio** pass it as us-east-2.
 

4. Enter `Account ID` from the above information, then click on `Next`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/acc-log-in.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter `IAM username` and `Password` from the above information and click on `Sign In`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/acc-log-in-usrpass.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/homepage-aws-console.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/region.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Set Up Terraform Provider For AWS


1. Click on `Apps Icon` and Open `Visual Studio Code`

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Click on `Terminal` and choose `New Terminal` to open terminal in `Visual Studio Code`

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. We have pre installed `Terraform` in AppStream VM. Execute `terraform --version` command in terminal to see the version of the Terraform.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

4. To install Terraform plugins, click on `Extensions` icon in the left pane of `Visual Studio Code` as shown below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

5. Search for `Terraform`. You will be able to see `Terraform` plugins in the result list.

6. Choose `Terraform` plugin and click on `Install`.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. Create a directory named `TerraformAWS` by executing below command in visual studio terminal.

`mkdir TerraformAWS`

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

8. On top left corner, click on `File` and choose `Open Folder`

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

9. Paste `D:/Photonuser` in the dropdown and click on `Enter`.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Once click on enter, you will be navigated to `AppStreamUsers(D:)/PhotonUser` directory where TerraformAWS folder is created.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

11. Select `TerraformAWS` and click on `Select Folder`

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p2.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

12. Now TerraformAWS folder is opened in Visual Studio Code.


#### setting up the provider file.

1. Inside the folder, create a file named `provider.tf` by clicking on `new file` symbol beside the Folder name as shown below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Paste the below content in `provider.tf` and `save` the file.

```
provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. This `aws` Provider can be used to configure infrastructure in AWS Cloud Infrastructure. The provider needs to be configured with credentials for the AWS Cloud Infrastructure account.

`Below is the explanation of provider AWS arguments:`

`region`: An AWS Cloud Infrastructure region. <br>
`access_key`: This is a AWS access_key. <br>
`secret_key`:This is the AWS secret key. <br>

4.  Create a file named `variables.tf` in same directory and paste the below content in it.

```
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = ""
}
variable "VM_user_name" {
  default = "ubuntu"
}
```

5. Update the below respected values inside the `double quotes` after `default =` in `variables.tf` file.

**access_key:**  {{access_key}} <br>
**secret_key:**  {{secret_key}}<br>
**region:** {{region}} <br>

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/2.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

6. Open the terminal in `Visual Studio code`

7. Execute `terraform init` command to initialize the current working directory with terraform. AWS Terraform plugins will be downloaded.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/4.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create And Deploy A Virtual Private Cloud Using Terraform

### Create A Virtual Private Cloud

1. Create a file named `vpc.tf`

2. Paste the below content in the `vpc.tf` and save the file.

```
resource "random_id" "random_id" {
  byte_length = 2
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tl_vpc"
  }
}
```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/3.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Below is the explanation of resource.

`resource "random_id":` The resource random_id generates random numbers that are intended to be used as unique identifiers for other resources.<br> 
`resource "aws_vpc":` Manages a virtual Private Cloud.<br>
`cidr_block:` The address space that is used for the virtual private cloud.<br>
`tags`: You can mention key and value pairs e.g.name of the vpc

### Deploy Virtual Private Cloud

1. Make sure you update `access_key` and `access_secret` in `variables.tf` file.

2. Make sure you save all the files.

3. Execute `terraform init` command to download the plugins for random_id.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/4.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of resources that are going to deploy in the AWS Cloud.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/5.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

6. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/6.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. You will get ```Apply complete! Resources: 2 added, 0 changed, 0 destroyed``` message once the deployment is completed.

8. Click on `switch` window icon and select `Chrome` browser to go back to the AWS Console.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/7.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

9. Navigate to the **services** of the AWS console and choose **VPC**--> select **your vpc's** to see the created virtual private cloud resource.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p6.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/8.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/9.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/10.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Now you have successfully deployed VPC using terraform templates. Click on `switch` window icon and go back to the `visual studio code` to create templates for other resources that are required for a instance.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Create EC2 Instance And Related Resources Using Terraform

### Create Subnet

1. Create a file named `subnet.tf` and paste the below content.

```
resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "tl_subnet_${random_id.random_id.hex}"
  }
}
```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/12.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "aws_subnet":` Manages a subnet with in the virtual private cloud.<br>
`vpc_id:` The resource id of the virtual private cloud in which subnet need to deploy.<br>
`cidr_block:` The address space that is used for subnet.<br>
`Name:` The dispaly name of the resource.<br>

### Create Internet Gateway

1. Create a file named `igw.tf` and paste the below content.

```
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "tl_igw_${random_id.random_id.hex}"
  }
}
```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/13.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "aws_internet_gateway":` Manages a internet gateway.<br>
`vpc_id:` The resource id of the virtual private cloud to which the internet gateway needs to attach.<br>
`Name:` The dispaly name of the resource.<br>

### Create Route table

1. Create a file named `routetable.tf` and paste the below content.

```
resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "tl_rt_${random_id.random_id.hex}"
  }
}
resource "aws_route_table_association" "sub-associate" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.rt.id}"
}
```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/14.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "aws_route_table":` Manages a Route table.<br>
`vcn_id:` The resource id of the virtual private cloud to which the route table needs to attach.<br>
`route:` Manages the route rules <br>
`cidr_block:` The address space that is used for routing.<br>
`gateway_id:` The resource id of the internet gateway to which the route table needs to attach.<br>
`Name:` The dispaly name of the resource.<br>

`resource "aws_route_table_association":` This resource is used to associate the route table with subnet.<br>
`subnet_id:` The resource id of the subnet to which the route table needs to associate. <br>
`route_table_id:` The resource id of the routetable.<br>

### Create Security List
1. Create a file named `secgrp.tf` and paste the below content.

```
resource "aws_security_group" "sg_list" {
  name        = "tl_sglist_${random_id.random_id.hex}"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/15.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "aws_security_group":` Manages a security group.<br>
`name:` The dispaly name of the resource.<br>
`vpc_id:` The resource id of the virtual private cloud to which the route table needs to attach.<br>
`ingress:` Manages the inbound security rules <br>
`from_port:` Source Port number.<br>
`to_port:` Destination Port Number.<br>
`protocol:` Name of the protocol to which the rule is applied.<br>
`cidr_blocks:` The address space that the rule need to be applied. <br>
`egress:` Manages the outbound security rules <br>
`from_port:` Source Port number.<br>
`to_port:` Destination Port Number.<br>
`protocol:` Name of the protocol to which the rule is applied.<br>
`cidr_blocks:` The address space that the rule need to be applied. <br>

### Create EC2 Instance
1. Create a file named `instance.tf` and paste the below content.

```
resource "aws_instance" "instance" {
  ami                         = "ami-0d1cd67c26f5fca19"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.sg_list.id}"]
  associate_public_ip_address = true
  subnet_id                   = "${aws_subnet.subnet.id}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  tags = {
    Name = "tl_instance_${random_id.random_id.hex}"
  }
}
resource "aws_key_pair" "key_pair" {
  key_name   = "tl_labs_key_${random_id.random_id.hex}"
  public_key = "${var.ssh-pub-key}"
}

```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/16.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "aws_instance":` Manages a EC2 Instance.<br>
`ami:` The ID of the Amazon Machine Image in a deployed region (us-west-2).It varied from region to region.<br>
`instance_type:` The Image sku that we are using in to launch the instance.<br>
`vpc_security_group_ids:`  A list of security group IDs to associate with instance.<br>
`associate_public_ip_address:` Associate a public ip address with an instance in a VPC.<br>
`subnet_id:` The VPC Subnet ID to launch in.<br>
`key_name:` The key name of the Key Pair to use for the instance.<br>
`Name:` Name of the resource. <br>
`resource "aws_key_pair":` A key pair is used to control login access to EC2 instances.<br>
`key_name:` The name for the key pair.<br>
`public_key:` The public key material.<br>

3. To generate an SSH key with PuTTYgen, follow these steps:

`3.1.`  Open the PuTTYgen program.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/19-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`3.2.`  For Type of key to generate, select SSH-2 RSA.

`3.3.`  Click the Generate button.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Note:** Move your mouse in the area below the progress bar. When the progress bar is full, PuTTYgen generates your key pair.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`3.4.` Type a passphrase in the Key passphrase field. Type the same passphrase in the Confirm passphrase field. You can use a key without a passphrase, but this is not recommended.

`3.5.`  Right-click in the text field labeled Public key for pasting into OpenSSH authorized_keys file and choose Select All.

`3.6.`  Right-click again in the same text field and choose Copy.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

> Note: Make sure to copy and paste the key in variables.tf file under the variable **sshPublicKey**.

`3.7.`  Click the Save private key button to save the private key. Warning! You must save the private key. You will need it to connect to your machine.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/24-0.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/p3.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Also follow the below steps to save the pem key file which will be used in further(while deploying null resource or extension resource we need pem file to connect to the vm and install the script.)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/49.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/50.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p4.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p5.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

4. Update the `variables.tf` with below content.

```
    variable "ssh-pub-key"{
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgy6VP1j4VcVvQ1q6+D1YXU+SVZDGYpKS0wyd/4rQD1OmGOt6jyIBlQ95DgJR2iK1FUK8gQeVwJ0IXuNlGwImFihf3jbnin/FBxJdkETgt0ttPB1wPYL56us1aa9blj0e/FST2OXJ0UrQ3IBzpL7oA83liPYJ4ZzAvGpwJc6N8BmR4+n1KXzQW/D05fc5anM12e5IZcDVKONnXzz0IBOkXWoHQT9YyTIL4iz065CxXSdA5VAf4bbLy1NcIoPBUuV1pyui3RWXfytglY3wqY3UcKYgIIz8ykMRR3ckLsucjk6Guc50TNYremszDRaStjSqJ8ZNmNtMFHzXK4hn1MKKqw== rsa-key-20200203"
}
```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/17.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


5.  Create a file named `outputs.tf` and paste the below content. 

```
output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}
output "vm_username" {
  value = "${var.VM_user_name}"
}

```
It will provide the VM Username and IPAddress after deploying the EC2 Instance in the AWS cloud.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/16-1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


### Deploy The Templates For Creating EC2 Instance

1. Make sure you update value of `{{sshPublicKey}}` in `variables.tf` file.

2. Make sure you save all the files.

3. Execute `terraform init` command to download the plugins for random_id.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/18.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  
 
4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of resources that are going to deploy.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/19.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/20.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
You will get Plan: 7 to add, 0 to change, 0 to destroy message.

5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

6. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/21.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/22.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. You will get ```Apply complete! Resources: 7 added, 0 changed, 0 destroyed``` message once the deployment is completed also the outputs of vm.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/23.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/31-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Check The Deployed Resources In AWS Console.

8. Click on `switch` window icon and select `Chrome` browser to go back to the AWS Console.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/p6.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

9. Navigate to the **Services** of the AWS console and choose **EC2**--> select **instances** to see the created EC2 Instance resource.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/24.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/25.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/26.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Now you have successfully deployed EC2 Instance using terraform templates. Click on `switch` window icon and go back to the `visual studio code` to create templates for other resources that are required for a EC2 Instance.

### Connect To The EC2 Instance

1. Click on `switch` window icon and select `Visual Studio`.

2. Copy the `public_ip`.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/26.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Click on `Apps` icon and select `Putty`.

4. Paste the `public_ip`, make sure port is `22` and click on `open`.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/34-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/27.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/28.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Choose the privatekey name and click on open.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/29.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


5. Click on `yes`.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/30.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

6. Enter username as `ubuntu`

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/31.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


7. Now you have successfully log in to the EC2 Instance.

## Install Apache Using Terraform

### Create Script for Apache Installation

1. Click on `switch` window icon and select `Visual Studio`.

2. Create a file named `apache-install.sh` and paste the below content.

```
#!/bin/bash

echo "---------------------Update the packages---------"
sudo apt-get update -y
echo "--------------------Install Apache--------------"
sudo apt-get install apache2 -y

# exit
```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/33.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. End of Line Sequence should be `LF` for the script. Otherwise you will get errors while executing the script.

4. To select `LF` as the end of line sequence, Click on `CRLF` at the bottom right corner of Visual Studio

  
### Create Null Resource Template For Installing Apache

1. Create a file named `extension.tf` and paste the below content.

```
resource "null_resource" "install_apache" {
  connection {
    type        = "ssh"
    host        = "${aws_instance.instance.public_ip}"
    user        = "${var.VM_user_name}"
    private_key = "${(file(var.ssh-pvt-key))}"
  }
  provisioner "file" {
    source      = "./apache-install.sh"
    destination = "/home/${var.VM_user_name}/apache-install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.VM_user_name}/apache-install.sh",
      "cd /home/${var.VM_user_name}/",
      "./apache-install.sh >> remote-exec.log"
    ]
  }
}
```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/34.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

We also need `pem file` of the `sshpublic key` to run the extension in the vm. For that create a file named as `instance_pvt_key.pem` and paste the pem key.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/32.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "null_resource":` The null_resource resource implements the standard resource lifecycle but takes no further action.<br>

`provisioner "file":` The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.<br>

`provisioner "remote-exec":` The remote-exec provisioner invokes apache script on a EC2 Instance after it is created.<br>

3. Update the `variables.tf` with below content and save the file.

```
    variable "VM_user_name" {
        default = "ubuntu"
    }
    variable "ssh-pvt-key" {
        default= "./instance_pvt_key.pem"
    }
```
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/34-1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Execute `terraform init` command on terminal to download null resource plugins.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/35.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of 
resources that are going to deploy.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/36.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

5. You will get ```Plan: 1 to add, 0 to change, 0 to destroy``` message.

6. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

7. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/37.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 
 
![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/38.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

8. You have successfully installed apache inside the EC2 Instance using terraform.

9. Click on `Switch windows` icon and select Chrome.

10. Browse the `public_ip` in new tab.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/Terraform/Images/39.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

11. Apache is installed successfully through Terraform templates.

`Conclusion:` Congratulations! You have successfully completed Terraform on AWS lab for creating a EC2 Instance and for adding extension to it using Terraform templates. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab.
