# Interconnect Setup between Oracle Cloud Infrastructure and Microsoft Azure

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Network Setup in Azure](#network-setup-in-azure)

[Network Setup in OCI](#network-setup-in-OCI)

[Setup Azure ExpressRoute](#setup-azure-expressroute)

[Setup Oracle Cloud Infrastructure FastConnect](#setup-oracle-cloud-infrastructure-fastconnect)

[Link VNet to Azure ExpressRoute](#link-vNet-to-azure-expressroute)

[Associate Network Security groups and Route table to Azure VNet](#associate-network-security-groups-and-route-table-to-azure-vnet)

[Configure OCI VCN Security Lists and Route Table](#configure-oci-vcn-security-lists-and-route-table)

[Test your Connection](#test-your-connection)

## Overview

This document will walk through the details of setting up this interconnect between Oracle and Azure.
Following is a high level diagram shows am Azure VNet (Virtual Network) that is connected to a Oracle VCN (Virtual Cloud Network). Resources in the VNet use the logical circuit that runs on the cross-cloud connection between Azure and Oracle Cloud Infrastructure to connect with resources in the VCN.

![](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/1.png)

OCI-Azure Interconnect
Lets continue and setup one by one each component to exactly enable such a connection.

Assumptions:
•	Users have access to OCI and Azure Tenancy
•	Have necessary required policies to create resources in OCI and Azure. Can find more details [here](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/azure.htm?source=post_page---------------------------)


## Pre-Requisites

Microsoft Azure:<br>
 In order to setup this interconnect, there are some pre-requisites that we need to complete for this setup: Azure Virtual Network (VNet) with subnets that can host a test virtual machine, and an Azure virtual network gateway.

Oracle Cloud:<br>
 Similarly on the Oracle Cloud Infrastructure side (OCI), we need to create a virtual cloud network with subnets and attach a dynamic routing gateway.

## Network Setup in Azure

open **portal.azure.com** on webbrowser. Use below details to loging to azure portal.<br>
**Azure_user_login_id:** {{az-username}}<br>
**Azure_Login_Password:** {{az-password}}<br>
**Resource_Group_name:** {{rg-name}}


Sign in to the Azure portal.  Please take Azure credentials from workspace access info.

### VNET and Subnet Creation

- On the upper-left side of the screen, select Create a resource > Networking > Virtual network.
- Add in the required details as shown below, leave the rest to default and select Create.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/2.png)

This creates a virtual network (VNet) and a subnet, which are scoped to a single region with in Azure. Resources within the virtual network can communicate outbound with the internet, by default. 
An inbound connection can be achieved by attaching a public IP with the resource. You can also connect virtual network with your on-premises network or other public clouds (Oracle Cloud Infrastructure) by using **Azure ExpressRoute**. This connection is private. Traffic does not go over the internet.

### virtual network gateway Creation

In order to create the interconnect between Azure virtual network and oracle cloud infrastructure virtual cloud network (VCN), we must create a virtual network gateway first. A virtual network gateway serves two purposes: exchange IP routes between the networks and route network traffic.

- On the upper-left side of the screen, search for ‘virtual network gateway’ resource and click on Create. It opens up the virtual network gateway options. 
- Add in the details as shown below. Remember to select ‘**ExpressRoute**’ in gateway type.
**Virtual Network Gateway Details**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/3.png)

**Virtual Network and Gateway Network**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/4.png)

**Public IP for Virtual Network Gateway**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/5.png)

It make take up to 45 minutes for creating the virtual network gateway.

In the meantime, lets setup a virtual machine in your virtual network to test the connectivity once the interconnect is successfully setup.

### Virtual Machine Creation

- On the upper-left side of the screen, select Create a resource > Compute > Ubuntu Server. 
- Add in the required details and leave the rest as default.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/6.png)

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/7.png)

This completes our pre-requisites for Microsoft Azure.

## Network Setup in OCI

Sign into the OCI console. Please take login credentials from workspace access info

### Virtual cloud network Creation 

- One the top left of the screen, select Menu > Networking > Virtual Cloud Networking > Create a Virtual Cloud Network.
- Add in the required details and Select **Create Virtual Cloud Network plus related resources**. The dialog box expands to list the items that will be created with your cloud network.

**Create Virtual Cloud Network plus related resources**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/8.png)

**Resources to be created**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/9.png)

**Subnets automatically created**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/10.png)

A virtual cloud network is a software defined version of a network, and allows you to create a virtualized datacenter in any oracle cloud infrastructure region. The subnets are scoped within a particular virtual cloud network and can be availability domain specific or regional.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/11.png)

Now that we have created basic virtual cloud network components,

### Dynamic routing gateway (DRG) Creation

- lets go ahead and create a dynamic routing gateway (DRG). A DRG can be considered as a virtual router that allows private traffic connectivity between your virtual cloud network and the networks outside of your VCN, that can be VCN in another region, a virtual network in another cloud or on-premise network.

- One the top left of the screen, select Menu > Networking > Dynamic Routing Gateway > Create Dynamic Routing Gateway.

**Create Dynamic Routing Gateway**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/12.png)

It takes usually 3/4 minutes to create a DRG. Once the DRG is created, go ahead and attach that DRG with your VCN.

**Attach VCN to DRG**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/13.png)

- Once the DRG is attached to VCN, your pre-requisites are completed for Oracle Cloud Infrastructure. 

Before we move ahead, lets create a virtual machine here in OCI VCN as well for testing.

#### Virtual Machine Creation 

One the top left of the screen, select Menu > Compute > Instances > Create Instance. 

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/14.png)
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/15.png)
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/16.png)

Now that the pre-requisites are completed, lets continue with the process of creating the interconnect between Microsoft Azure and Oracle Cloud Infrastructure.

## Setup Azure ExpressRoute

### Create ExpressRoute

- On the upper-left side of the screen, select Create a resource > ExpressRoute and select Create.
- Add in the required details as shown below. Choose Oracle Cloud FastConnect as the provider, and currently my region is EastUS for Azure.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/17.png)
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/18.png)

This creates an ExpressRoute circuit, however its not currently provisioned and doesn’t provide any connectivity details. Note down the service key as we will use this afterwards in Oracle Cloud Infrastructure.

## Setup Oracle Cloud Infrastructure FastConnect

### FastConnect creation

- In OCI Console, navigate to the Menu > Networking > FastConnect > Create Connection. 
- Choose the connect through provider and select Microsoft Azure ExpressRoute.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/19.png)

Choose a private virtual circuit creation, provide details of your dynamic routing gateway and add in the service key copied from Azure here.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/20.png)

The connection between Azure VNet and OCI VCN uses BGP dynamic routing. Provide the BGP IP addresses that will be used for the two redundant BGP sessions between Oracle and Azure:
  - A primary pair of BGP addresses
  - A separate, secondary pair of BGP addresses

I have provided here /30 addresses here for the BGP connection. The second and third in each /30 are used as BGP IP address pair. The second address in the block is for the Oracle side of the BGP session and the third address in the block is for the Azure side of the BGP session.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/21.png)

Initially the circuit will go into provisioning.

Shortly after the circuit goes into ‘UP’ status with its lifecycle state as ‘Provisioned’.

**UP Status of FastConnect virtual circuit.**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/22.png)

**Details page of FastConnect Virtual Circuit**
UP Status of FastConnect virtual circuit.
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/23.png)

Similarly on the Azure side, the circuit status has changed into provisioned as well.

**Azure ExpressRoute Provisioned Status and Peering details**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/24.png)

## Link VNet to Azure ExpressRoute

Next step is to create a link between the Azure Virtual Network and ExpressRoute circuit and configure security groups and routing for the virtual network.

On your dashboard navigate to your virtual network gateway > connections > select Add and configure the values.

**Configure Values for connection**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/25.png)

Connection to ExpressRoute successful
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/26.png)

## Associate Network Security groups and Route table to Azure VNet

### create Network Security group

- On the upper-left side of the screen, select Create a resource > Network Security Group > select Create.
- Configure the values to create a network security group.

**Network Security Group**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/27.png)

Associate the network security group to the subnet in your VNet hosting your virtual machine. Select the newly created network security group from the dashboard, select Subnets and Associate. Select the VNet and subnet required.

**Associate VNet Subnet to Network Security Group**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/28.png)

Add relevant security group rules to allow traffic from Virtual Cloud Network on Oracle Cloud Infrastructure. We will start with some basic ping tests using the ICMP protocol.

- Navigate to the newly created network security group from the dashboard, 
- select Inbound Security Rules > select Add. Add two rules, one for ssh connection into the Azure VM and another rule for connection between OCI VCN Subnet (10.0.0.0/24) to Azure VNet Subnet (172.26.0.0/24).

Inbound Network Security Group Rules:
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/29.png)

### Create Route Table

- Navigate to the upper-left side of the screen, select Create a resource > Route Table > select Create. 
- Configure the values to create a route table.

**Route table Creation**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/30.png)

Once the new route table is created, associate the route table with the VNet Subnet hosting your virtual machine and add a route.

The following figure shows the route with address prefix is Oracle Cloud Infrastructure VCN CIDR (In our example: 10.0.0.0/16) and the next hop is the Azure Virtual Network Gateway.

**Adding a Route to the Route Table**
![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/31.png)

We have created an ExpressRoute, linked it with our Virtual Network Gateway and configured network security group and route table to allow traffic connectivity with OCI VCN.

## Configure OCI VCN Security Lists and Route Table

Navigate to the details of the Virtual Cloud Network and configure the security lists and route table associated with your subnet hosting your virtual machine.

### Create Security lists

- Virtual Cloud Network > Security Lists > Default Security List > Add Ingress Rule with source CIDR of the Azure VNet Subnet (172.26.0.0/24). This opens up all protocols traffic between the two virtual networks. 

**Security List Rule**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/32.png)

### create Route table

Moving ahead, lets navigate to Virtual Cloud Network > Route table > Default Route table > Add Route rule with Destination CIDR of Azure VNet (172.26.0.0/16) and DRG as your target. This will add a route table entry for routing the traffic towards Azure VNet.

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/33.png)

## Test your Connection

Lets go ahead and test the connection.

We have virtual machines in each virtual network. Lets test out connectivity by doing a basic PING test.

- OCI VM Private IP: 10.0.0.2
-	Azure VM Private IP: 172.26.0.4

**Azure VM PING Test to OCI VM Private IP**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/34.png)

**OCI VM PING test to Azure VM Private IP**

![alt-txt](https://github.com/sysgain/qloudable-tl-labs/raw/tl-labs/OCI-Azure-Interconnect/images/35.png)

There you go! The connection is successful. We are able to PING traffic from either direction i.e. OCI — Azure.
