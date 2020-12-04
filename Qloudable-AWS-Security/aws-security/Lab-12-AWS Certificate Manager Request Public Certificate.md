# AWS Certificate Manager Request Public Certificate

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#signin-to-aws-console)

[Requesting a public Certificate using the Console](#requesting-a-public-certificate-using-the-console)

[Tear down this lab](#tear-down-this-lab)

## Overview

[AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) is a service that lets you easily provision, manage, and deploy public and private Secure Sockets Layer/Transport Layer Security (SSL/TLS) certificates for use with AWS services and your internal connected resources. SSL/TLS certificates are used to secure network communications and establish the identity of websites over the Internet as well as resources on private networks. AWS Certificate Manager removes the time-consuming manual process of purchasing, uploading, and renewing SSL/TLS certificates

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/acm_intro.png?st=2020-09-29T07%3A13%3A47Z&se=2025-09-30T07%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zivHs%2FtMId2D7QbjePYmG9sMZdCifsINMcJQWAbsu00%3D)

**Learning Objectives**

1. Request AWS Certificate Manager public certificate.

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

1. An AWS account that you are able to use for testing, that is not used for production or other purposes

## Signin to AWS Console

1. Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2. Sign in to the console using below **AccountID**, **IAM username** and **Password** details:

  * **Account ID:** `{{Account ID}}` <br>
  * **IAM username:** `{{username}}` <br>
  * **Password:** `{{password}}`

3. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

4. Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Requesting a public certificate using the console

1. Click on Services and search for **Certificate Manager** in search box and select **Certificate Manager** from dropdown.

2. If you see a welcome page, click **Get started** under provision certificates area.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c1.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

3. On the Request a certificate page, click **Request a public certificate**, then click Request a certificate.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c2.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

4. Type your domain name. You can use a fully qualified domain name (FQDN) such as `www.example.com` or a bare or apex domain name such as `example.com`. You can also use an asterisk `*` as a wildcard in the leftmost position to protect several site names in the same domain. For example, `*.example.com` protects `corp.example.com`, and `images.example.com`. The wildcard name will appear in the Subject field and the Subject Alternative Name extension of the ACM certificate.

**Note:** When you request a wildcard certificate, the asterisk `*` must be in the leftmost position of the domain name and can protect only one subdomain level. For example, `*.example.com` can protect `login.example.com`, and `test.example.com`, but it cannot protect `test.login.example.com`. Also note that `*.example.com` protects only the subdomains of `example.com`, it does not protect the bare or apex domain `example.com`. To protect both, see the next step.

5. To add more domain names to the ACM certificate, choose **Add another name to this certificate** and type another domain name in the text box that opens. This is useful for protecting both a bare or apex domain (like `example.com`) and its subdomains `*.example.com`.

6. After you have typed valid domain names, choose **Next**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c3.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

7. Before ACM issues a certificate, it validates that you own or control the domain names in your certificate request. You can use either **email validation** or **DNS validation**. If you choose email validation, ACM sends validation email to three contact addresses registered in the WHOIS database and to five common system administration addresses for each domain name. You or an authorized representative must approve one of these email messages. If you use DNS validation, you simply create a CNAME record provided by ACM to your DNS configuration. Choose your option, then click **Review**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c4.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

**Note:** If you are able to edit your DNS configuration, we recommend that you use DNS domain validation rather than email validation. DNS validation has multiple benefits over email validation. See Use DNS to Validate Domain Ownership.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c5.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

8. If the review page correctly contains the information that you provided for your request, choose **Confirm and request**. The following page shows that your request status is pending validation. You must approve the request either through email link or DNS record.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Certificate%20Manager%20Request%20Public%20Certificate/c6.png?st=2020-02-12T04%3A55%3A06Z&se=2023-02-13T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=T6BFIHIpuxoVw5XACbSfKGwvrMaEtgvFWYgChw0Id0w%3D" alt="image-alt-text" >

**Important:** Unless you choose to opt out, your certificate will be automatically recorded in at least two public certificate transparency databases. You cannot currently use the console to opt out. You must use the AWS CLI or the API. For more information, see [Opting Out of Certificate Transparency Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-bestpractices.html#best-practices-transparency). For general information about transparency logs, see [Certificate Transparency Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency).

9. Your certificate is now ready to associate with a [supported service](https://docs.aws.amazon.com/en_pv/acm/latest/userguide/acm-services.html).

## Tear down this lab

1. Sign into the AWS Management Console and open the ACM console at [https://console.aws.amazon.com/acm/home](https://console.aws.amazon.com/acm/home). Select the region where you created the certificate.

2. Click the check box for the domain name of the certificate to delete. Click Actions then Delete.

3. Verify this is the certificate to delete and click Delete. Note: You cannot delete an ACM Certificate that is being used by another AWS service. To delete a certificate that is in use, you must first remove the certificate association.

**Conclusion:** Congratulations! You have successfully completed the lab **AWS Certificate Manager Request Public Certificate**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

[AWS Certificate Manager](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)

[Create an HTTPS Listener for Your Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
