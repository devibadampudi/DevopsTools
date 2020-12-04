# Implement Web Apps

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Create an Azure web app](#create-an-azure-web-App)

[Create a staging deployment slot](#create-a-staging-deployment-slot)

[Configure web app deployment settings](#configure-web-app-deployment-settings)

[Deploy code to the staging deployment slot](#deploy-code-to-the-staging-deployment-slot)

[Swap the staging slots](#swap-the-staging-slots)

[Configure and test autoscaling of the Azure web app](#configure-and-test-autoscaling-of-the-azure-web-app)

[Conclusion](#conclusion)

## Overview

The Main Aim of this lab is to evaluate the use of Azure Web apps for hosting Contoso's web sites, hosted currently in the company's on-premises data centers. The web sites are running on Windows servers using PHP runtime stack. 

**Scenario & Objectives**

You need to evaluate the Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure virtual machines. To accomplish this, you intend to examine the capabilities of Azure Monitor, including Log Analytics. 

In this lab, you will learn:

1. Create an Azure web app

2. Create a staging deployment slot

3. Configure web app deployment settings

4. Deploy code to the staging deployment slot

5. Swap the staging slots

6. Configure and test autoscaling of the Azure web app

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites
 
* Azure Fundamentals
  
## Create an Azure web app

In this task, you will create an Azure web app. 

1. Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/azure-login.png?st=2020-10-12T10%3A06%3A23Z&se=2025-10-13T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lwrr44qp2B5hf62bzKLFWVEJN0S%2B5oecN13SpY4r89g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/azure-login2.png?st=2020-10-12T10%3A09%3A18Z&se=2025-10-13T10%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pkEyPZ0Bx7z5o4GibBO5Pz1%2BX0PXJ4gxZI4MX2EjT3w%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/azure-login3.png?st=2020-10-12T10%3A10%3A06Z&se=2025-10-13T10%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2%2B68mbtfbzaUmJhOWsB4kBMr0gUff1Hwy1iftdJuhjk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/azure-login4.png?st=2020-10-12T10%3A10%3A45Z&se=2025-10-13T10%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zqPtelbrc108VMOzQ1VMbEb0DIfpSjs4A6aj%2FmH7Etw%3D)

2. In the Azure portal, search for and select **App services**, and, on the **App Services** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/appservice-search.png?st=2020-10-12T10%3A12%3A52Z&se=2025-10-13T10%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rn6FLdny6Zs7ybg2v%2FFGZWHs0rB5uQmhexLPuE0nQug%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/appservices-add.png?st=2020-10-12T10%3A15%3A14Z&se=2025-10-13T10%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=03aPPuXtqdxMUh2PKRrYPlEk5QfOLOIFk1Vg21gYouA%3D)

3. On the **Basics** tab of the **Web App** blade, specify the following settings (leave others with their default values):

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/appsevice-basic.png?st=2020-10-12T10%3A17%3A35Z&se=2025-10-13T10%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DbZIM3fYWTAXIxcfgFXtwwdvvXt%2BTar8JYmcYu9V4dI%3D)

> **Settings:**

* **Subscription:** the name of the Azure subscription you are using in this lab 
* **Resource group:** {{resource-group-name}}
* **Web app name:** any globally unique name 
* **Publish:** Code 
* **Runtime stack:** PHP 7.3 
* **perating system:** Windows  
* **Region:**  {{Location}}
* **App service plan:** accept the default configuration 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/createwebapp1.png?st=2020-10-12T10%3A25%3A22Z&se=2025-10-13T10%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CXueVKcpbuQUo1k1u0nVQo9OnAk9Xw7e0DtHhQJo6m4%3D)

4. Click **Next : Monitoring >**, on the **Monitoring** tab of the **Web App** blade, set the **Enable Application Insights** switch to **No**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/monitoring1.png?st=2020-10-12T10%3A28%3A06Z&se=2025-10-13T10%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Pdhfb2xnfp%2FXLQrviKrEynPN9%2BUruRxEajPXmbq9tOo%3D)

5. click **Review + create**, and then click **Create**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/review-create.png?st=2020-10-12T10%3A30%3A59Z&se=2025-10-13T10%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wGn8MJC%2BHsm072QvJsdusU4Hn8pJbPdwaNJEZr5HZJU%3D)

> **Note**: Typically, you would want to enable **Application Insights**, however, its functionality is not used in this lab.

> **Note**: Wait until the web app is created before you proceed to the next task. This should take about a minute. 

6. On the deployment blade, click **Go to resource**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/gotoresource.png?st=2020-10-12T10%3A34%3A32Z&se=2026-10-13T10%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5uvDvqRUU3zKW6CdYb8U5534nwmgZkfLvwohaU75as0%3D)

## Create a staging deployment slot

In this task, you will create a staging deployment slot. 

> **Note:** Set you screen resolution to 1280*720

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/screen-resolution.png?st=2020-11-06T06%3A45%3A06Z&se=2025-11-07T06%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DgPBfy42H3%2Fe2KOfTSTvROymv7vLwIN2rMQz5rti6dc%3D)

1. On the blade of the newly deployed web app, click the **URL** link to display the default web page in a new browser tab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/webappURL.png?st=2020-10-12T10%3A36%3A37Z&se=2025-10-13T10%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m9RS%2FCUEtN0VfbYfzaubaXAlKW0Y%2FiwuUeZnHNUdjK0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/URL.png?st=2020-10-12T10%3A38%3A14Z&se=2025-10-13T10%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=A5oRbUUepErXzs7bxxej4UiaHrXCY0KS6axMcqWirIU%3D)

2. Close the new browser tab and, back in the Azure portal, in the **Deployment** section of the web app blade, click **Deployment slots**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/deployment-slots.png?st=2020-10-12T10%3A39%3A58Z&se=2025-10-13T10%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9WYOcuOmN98ZDbkYByeV%2B4e4jUeCCsxyRUdqpYtKbgQ%3D)

> **Note**: The web app, at this point, has a single deployment slot labeled **PRODUCTION**. 

3. Click **+ Add slot**, and add a new slot with the following settings: 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/addslot.png?st=2020-10-12T10%3A42%3A18Z&se=2025-10-13T10%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UlJ0T0lC5kVbDnd3%2BgwxdlfcCYx%2FoSizafzkPP8DwNM%3D)

> **Settings**
 
* Name : **staging** 
* Clone settings from :  **Do not clone settings**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/slotconfiguration.png?st=2020-10-12T10%3A47%3A32Z&se=2025-10-13T10%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CP6RtxHtWeaQAMQiiceExTjWKiDK0p%2FOStvf1wJGTbc%3D)

4. Back on the **Deployment slots** blade of the web app, click the entry representing the newly created staging slot. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/slotstaging.png?st=2020-10-12T10%3A50%3A18Z&se=2025-10-13T10%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s9x5eNdhIuXRKCPJqinqdz%2Ff9MH%2BENxb0TZ%2FMs6QKys%3D)

> **Note**: This will open the blade displaying the properties of the staging slot. 

5. Review the staging slot blade and note that its URL differs from the one assigned to the production slot.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/url-staging.png?st=2020-10-12T10%3A52%3A37Z&se=2025-10-13T10%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tQB0GcyZow8xGSTFXwJFF5addo8ypZTeh941zJPSS%2BY%3D)

## Configure web app deployment settings

In this task, you will configure web app deployment settings. 

1. On the staging deployment slot blade, in the **Deployment** section, click **Deployment Center**.

> **Note:** Make sure you are on the staging slot blade (rather than the production slot).
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/deployment-center.png?st=2020-10-12T10%3A54%3A57Z&se=2025-10-13T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rlce2T31fDl55q8yoOJBoHsmHkNUt7U9i0e5oi%2BjsEc%3D)

2. In the **Continuous Deployment (CI/CD)** section, select **Local Git**, and then click **Continue**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/local-git.png?st=2020-10-12T10%3A57%3A29Z&se=2025-10-13T10%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q7S0BDjeteaDOBClpM5itgFXeDwR1jfgjTaldLNXvbg%3D)

3.  Select **App Service build service**, click **Continue**, and then click **Finish**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/appservice-buildservice.png?st=2020-10-12T10%3A59%3A12Z&se=2025-10-13T10%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HCObt3CZdiEgJVrKFblWgBxEj16AJjHT4kWl3kuy1DU%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/finish.png?st=2020-10-12T11%3A00%3A26Z&se=2025-10-13T11%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LqAXN1i7eVGP8kI3lLa4qMmtbobYBakCtxjU2NVymfM%3D)

4. Copy the resulting **Git Clone Url** to Notepad.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/gitclone-url.png?st=2020-10-12T11%3A02%3A15Z&se=2025-10-13T11%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nC5JDYVHUjhK3It7AOl7z7mkduXSyNN5Qo3cmuENabk%3D)

> **Note:** You will need the Git Clone Url value in the next task of this lab.

5. Click **Deployment Credentials** toolbar icon to display **Deployment Credentials** pane. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/deployment-credentials.png?st=2020-10-12T11%3A04%3A54Z&se=2025-10-13T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6QoxxcnPtxTMtWgr7RAFUj6NQv6u%2BvnVWynPFhUONPA%3D)

6. Click **User credentials**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/usercredentials.png?st=2020-10-12T11%3A06%3A35Z&se=2025-10-13T11%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ayfFEqI4Anp9olummh3NLwiZ%2BUi99VfeqXeN%2B91R6Tk%3D)

7. Complete the required information, and then click **Save Credentials**. 

> **Settings:**

* User name : any unique name (must not contain `@` character) 
* Password | any password that satisfies complexity requirements 
    
> **Note:** The password must be at least eight characters long, with two of the following three elements: letters, numbers, and non-alphanumeric characters.

> **Note:** You will need these credentials in the next task of this lab.
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/savecredentials.png?st=2020-10-12T11%3A10%3A26Z&se=2025-10-13T11%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=frEdQ%2BfsgjvcJILXZ%2FCqCf8jtWwENxhI8Za5IFnt%2F%2B0%3D)

## Deploy code to the staging deployment slot

In this task, you will deploy code to the staging deployment slot.

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

2. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

> **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 
        
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/cloudshell.png?st=2020-10-12T11%3A13%3A50Z&se=2025-10-13T11%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ommqbpP%2BiHhWs6XOJOmSBhGzGH3epKhQuZmiwJOAQ80%3D)

3. From the Cloud Shell pane, run the following to clone the remote repository containing the code for the web app.

   ```
   git clone https://github.com/Azure-Samples/php-docs-hello-world
   ```
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/gitclone-pwsh.png?st=2020-10-12T11%3A17%3A49Z&se=2025-10-13T11%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=d9xbVdP23z9Wmo7sPZi4mv7TZQxW79Al2U9yyTCJgc8%3D)
 
4. From the Cloud Shell pane, run the following to set the current location to the newly created clone of the local repository containing the sample web app code.

   ```
   Set-Location -Path $HOME/php-docs-hello-world/
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/setlocation.png?st=2020-10-12T11%3A20%3A05Z&se=2025-10-13T11%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dHpe7lPjoYCR3Cs%2ByFp9jGdWwFsbf4MwwRQo7ThAIU0%3D)
     
5. From the Cloud Shell pane, run the following to add the remote git (make sure to replace the `[deployment_user_name]` and `[git_clone_url]` placeholders with the value of the **Deployment Credentials** user name and **Git Clone Url**, respectively, which you identified in previous task):

   ```
   git remote add [deployment_user_name] [git_clone_url]
   ```

> **Note**: The value following `git remote add` does not have to match the **Deployment Credentials** user name, but has to be unique
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/gitremote.png?st=2020-10-12T11%3A23%3A33Z&se=2026-10-13T11%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2zcPbDaUYxbpG%2F%2FSQ7FIZvbML2MT0fiK0JveKclB4Y0%3D)

6. From the Cloud Shell pane, run the following to push the sample web app code from the local repository to the Azure web app staging deployment slot (make sure to replace the `[deployment_user_name]` placeholder with the value of the **Deployment Credentials** user name, which you identified in previous task):

   ```
   git push [deployment_user_name] master
   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/gitpush.png?st=2020-10-12T11%3A26%3A24Z&se=2025-10-13T11%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iwfg5jJrgeadkaWFe6smJlNiuhNZcU3%2B0cShVTjs014%3D)
  
7. If prompted to authenticate, type the `[deployment_user_name]` and the corresponding password (which you set in the previous task).

8. Close the Cloud Shell pane.

9. On the staging slot blade, click **Overview** and then click the **URL** link to display the default web page in a new browser tab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/slot-overview.png?st=2020-10-12T11%3A37%3A51Z&se=2025-10-13T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3FTRKeUN4rOUo7vHKo8KePBHnnFJnkHkJNzES6yx8GY%3D)

10. Verify that the browser page displays the **Hello World!** message and close the new tab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/hello-world.png?st=2020-10-12T11%3A39%3A19Z&se=2025-10-13T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mIzMS3C2QYCh9wE9F9MI7%2FOGeB1LJ1GsegvcI5n9kYw%3D)

## Swap the staging slots

In this task, you will swap the staging slot with the production slot

1. Navigate back to the blade displaying the production slot of the web app.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/prodslot.png?st=2020-10-12T11%3A41%3A58Z&se=2025-10-13T11%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OCU%2Fd1ah0HPdfkn6jhPNhXViasWDo09PqnubG5jFuEY%3D)

2. In the **Deployment** section, click **Deployment slots** and then, click **Swap** toolbar icon.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/swap.png?st=2020-10-12T11%3A43%3A17Z&se=2025-10-13T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aUb3Ipba%2FYTY1LrA6acg9XHV7kD1XD30ErQPkwREVCw%3D)

3. On the **Swap** blade, review the default settings and click **Swap**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/swap-prod.png?st=2020-10-12T11%3A45%3A08Z&se=2025-10-13T11%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3TvOa6nMRmHKZicTtLoENHCaxoS8KdfvH6%2FkqyJQwM8%3D)

4. Click **Overview** on the production slot blade of the web app and then click the **URL** link to display the web site home page in a new browser tab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/overview.png?st=2020-10-12T11%3A51%3A06Z&se=2025-10-13T11%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=M4ph56GhVc5vMbJaUCp97LSj04ii3XeFJIt7B6uljLo%3D)

5. Verify the default web page has been replaced with the **Hello World!** page. 

## Configure and test autoscaling of the Azure web app

> **Note**: You will need to confirm that Microsoft.Insights is registered on your subscription for this lab. For more information regarding this task, refer to https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types#azure-portal
    
In this task, you will configure and test autoscaling of Azure web app. 

1. On the blade displaying the production slot of the web app, in the **Settings** section, click **Scale out (App Service plan)**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/scaleout.png?st=2020-10-12T11%3A54%3A25Z&se=2025-10-13T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qWNmGXYUkDVBPmK%2FkYyL8gS2dGRQbpYrLYqv3i6l9zU%3D)

2. Click **Custom autoscale**. 

> **Note**: You also have the option of scaling the web app manually.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/custom-autoscale.png?st=2020-10-12T11%3A56%3A06Z&se=2025-10-13T11%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5avUixlGshEoxT2LIZrbZ%2BdqtsEYxKTlVBz7n4OLmvE%3D)

3. Leave the default option **Scale based on a metric** selected and click **+ Add a rule**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/addrule.png?st=2020-10-12T11%3A57%3A57Z&se=2025-10-13T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CaoWtjDFx%2BWK7dBREJu%2Bc0wU0IEddgYF2uaTyp%2F0xjs%3D)

4. On the **Scale rule** blade, specify the following settings (leave others with their default values):

> **Settings**

* Metric source :  **Current resource** 
* Time aggregation :  **Maximum** 
* Metric namespace : **App Service plans standard metrics** 
* Metric name :  **CPU Percentage** 
* Operator :  **Greater than** 
* Metric threshold to trigger scale action :  **10** 
* Duration (in minutes) :  **1** 
* Time grain statistic : **Maximum** 
* Operation :  **Increase count by** 
* Instance count : **1** 
* Cool down (minutes) : **5** 

> **Note**: Obviously these values do not represent a realistic configuration, since their purpose is to trigger autoscaling as soon as possible, without extended wait period.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/addrule-config.png?st=2020-10-12T12%3A01%3A12Z&se=2025-10-13T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eEPWCRLTMfH6lzvT6yHbp2446cKfSSTlsM25LZfDifo%3D)

5. Click **Add** and, back on the App Service plan scaling blade, specify the following settings (leave others with their default values):

> **Settings:**

* Instance limits Minimum : **1** 
* Instance limits Maximum : **2** 
* Instance limits Default : **1** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/rule-min.png?st=2020-10-12T12%3A03%3A03Z&se=2025-10-13T12%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6JEn5skgfVlJjbUJQxmhBLn6OTLfRUos3vifO1zgXpo%3D)

6. Click **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/save-rule.png?st=2020-10-12T12%3A04%3A17Z&se=2025-10-13T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mwvVePIlcuxQqUQEn%2F21BLvJeJi3viJ7m3ENSQugkPg%3D)

7. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

8. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/pwsh1.png?st=2020-10-12T12%3A06%3A31Z&se=2025-10-13T12%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y%2Bq17IIbT9UfUcVvQW1hPNSImEcAvqIsRVLOtc%2BPVI8%3D)

9. From the Cloud Shell pane, run the following to identify the URL of the Azure web app.

   ```
   $rgName = '{{resource-group-name}}'

   $webapp = Get-AzWebApp -ResourceGroupName $rgName
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/pwsh-resourcegroup.png?st=2020-10-12T12%3A09%3A06Z&se=2025-10-13T12%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yjoF4uwKu02rsUWyGUSaoJvT0Y9ztz%2FasIzZfJEEI0k%3D)

10. From the Cloud Shell pane, run the following to start and infinite loop that sends the HTTP requests to the web app:

   ```
   while ($true) { Invoke-WebRequest -Uri $webapp.DefaultHostName }
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/while-loop.png?st=2020-10-12T12%3A11%3A07Z&se=2025-10-13T12%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=93E2fS%2FkbFwevHxqk%2B6weHDAn%2FYFoxB1zcugXkpA4yM%3D)

11. Minimize the Cloud Shell pane (but do not close it) and, on the web app blade, in the **Monitoring** section, click **Process explorer**.

> **Note**: Process explorer facilitates monitoring the number of instances and their resource utilization. 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/monitoring-process-explorer.png?st=2020-10-12T12%3A13%3A44Z&se=2025-10-13T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jtQWVtB4gAD%2FSdNfIgtmuVF4YB4F%2Bh79Sa0o49ymXFM%3D)

12. Monitor the utilization and the number of instances for a few minutes.

> **Note**: You may need to **Refresh** the page.
        
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/monitor-few-instances.png?st=2020-10-12T12%3A15%3A04Z&se=2025-10-13T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oSAzytGSlMNHar%2FMrmj5WAOKz2NvahoI8peDOUoyJV4%3D)

13. Once you notice that the number of instances has increased to 2, reopen the Cloud Shell pane and terminate the script by pressing **Ctrl+C**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2009a%20-%20Implement%20Web%20Apps/closectrlc.png?st=2020-10-12T12%3A16%3A58Z&se=2025-10-13T12%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LrWpjFTfBqZ7IOu%2BZLnJBaSRJVszdvGSZ2aBdVeSdfg%3D)

14. Close the Cloud Shell pane.

###  Review

In this lab, you have:

* Created an Azure web app
* Created a staging deployment slot
* Configured web app deployment settings
* Deployed code to the staging deployment slot
* Swapped the staging slots
* Configured and test autoscaling of the Azure web app

## Conclusion

Congratulations! You have successfully completed the lab **Implimenting WebApps**!.Feel free to continue exploring or start a new lab.

![alt text](https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif)

Thank you for taking this training lab!
