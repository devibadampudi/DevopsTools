resource "random_id" "random_id" {
  byte_length = 2
}

resource "random_uuid" "uuid1" {}
resource "random_uuid" "uuid2" {}
resource "random_uuid" "uuid3" {}
resource "random_uuid" "uuid4" {}

resource "azuread_user" "user" {
  user_principal_name   = "${var.username}${random_id.random_id.hex}@qloudabletraininglabs.onmicrosoft.com"
  display_name          = "${var.username}${random_id.random_id.hex}"
  mail_nickname         = "${var.username}${random_id.random_id.hex}"
  password              = "${var.username}@1234"
  force_password_change = true
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.username}${random_id.random_id.hex}-rg"
  location = "${var.location}"

  tags = {
    environment = "Terraform Lab"
  }
}

resource "azurerm_role_definition" "role_definition" {
  role_definition_id = "${random_uuid.uuid1.result}"
  name               = "${var.username}${random_id.random_id.hex}_customrole"
  scope              = "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.resource_group.name}"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/deployments/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/networkInterfaces/read",
      "Microsoft.Compute/disks/read",
      "Microsoft.Compute/locations/*",      
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.ResourceHealth/availabilityStatuses/read",
    ]

    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.resource_group.name}",
  ]
}

resource "azurerm_role_assignment" "role_assignment" {
  name               = "${random_uuid.uuid2.result}"
  scope              = "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.resource_group.name}"
  role_definition_id = "${azurerm_role_definition.role_definition.id}"
  principal_id       = "${azuread_user.user.id}"
}

resource "azuread_application" "tf_app" {
  name                       = "${var.username}${random_id.random_id.hex}tfapp"
  homepage                   = "https://${var.username}${random_id.random_id.hex}tfapp"
  reply_urls                 = ["https://${var.username}${random_id.random_id.hex}tfapp"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  type                       = "webapp/api"
}

resource "azuread_application_password" "tf_pw" {
  application_object_id = "${azuread_application.tf_app.id}"
  value          = "${var.service_principle_password}"
  end_date       = "2020-01-01T01:02:03Z"
}

resource "azuread_service_principal" "tf-app-sp" {
  application_id = "${azuread_application.tf_app.application_id}"
  app_role_assignment_required  = true
}

resource "azuread_service_principal_password" "tf-app-sp_pw" {
  service_principal_id = "${azuread_service_principal.tf-app-sp.id}"
  value                = "${var.service_principle_password}"
  end_date             = "2020-01-01T01:02:03Z"
}

resource "azurerm_role_definition" "role_definition_ad" {
  role_definition_id = "${random_uuid.uuid4.result}"
  name               = "${var.username}${random_id.random_id.hex}_customrolead"
  scope              = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Network/publicIPAddresses/*",
      "Microsoft.Network/networkSecurityGroups/*",
      "Microsoft.Network/networkInterfaces/*",
      "Microsoft.Compute/disks/*",
      "Microsoft.Compute/locations/*",      
      "Microsoft.Compute/virtualMachines/*",
      "Microsoft.ResourceHealth/availabilityStatuses/read",
      # "Microsoft.ApiManagement/*",
      "Microsoft.MarketplaceOrdering/*",
    ]

    not_actions = [
      # "Microsoft.Authorization/*/Delete",
      # "Microsoft.Authorization/*/Write",
      # "Microsoft.Authorization/elevateAccess/Action",
      # "Microsoft.Blueprint/blueprintAssignments/write",
      # "Microsoft.Blueprint/blueprintAssignments/delete"
    ]
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.resource_group.name}",
    "/subscriptions/${var.subscription_id}"
  ]
}

resource "azurerm_role_assignment" "role_asgn_ad_app" {
  name               = "${random_uuid.uuid4.result}"
  scope              =  "/subscriptions/${var.subscription_id}"
  # role_definition_name = "Contributor"
  role_definition_id = "${azurerm_role_definition.role_definition_ad.id}"
  principal_id       = "${azuread_service_principal.tf-app-sp.object_id}"
}

resource"azurerm_policy_definition""policy_definition"{
name="${var.username}${random_id.random_id.hex}_customPolicy"
policy_type="Custom"
mode="All"
display_name="Terraform-policy-definition"
 
policy_rule=<<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "Microsoft.Compute/virtualMachines/sku.name",
        "in": "[parameters('allowedSkus')]"
      }
    },
    "then": {
      "effect": "deny"
    }
  }
POLICY_RULE
 
parameters=<<PARAMETERS
    {
    "allowedSkus": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed SKUs for resources.",
        "displayName": "Allowed SKUs",
        "strongType": "VMSKUs"
      }
    }
  }
PARAMETERS
 
}
 
resource"azurerm_policy_assignment""policy_assignment"{
name="${var.username}${random_id.random_id.hex}_customPolicyAssignment"
scope="/subscriptions/${var.subscription_id}"
policy_definition_id="${azurerm_policy_definition.policy_definition.id}"
description="Policy Assignment created via customPolicy"
display_name="Terraform-Policy-Assignment"
parameters=<<PARAMETERS
{
  "allowedSkus": {
    "value": [ "Basic_A1" ]
  }
}
PARAMETERS
}
