output "resource_group_name" {
  value = ["${azurerm_resource_group.resource_group.name}"]
}

output "Azure_user_login_id" {
  value = ["${azuread_user.user.user_principal_name}"]
}

output "Azure_login_password" {
  value = ["${azuread_user.user.password}"]
}

output "azure_rg_location" {
  value = ["${var.location}"]
}

output "servprnciple-appid" {
  value = ["${azuread_service_principal.tf-app-sp.application_id}"]
}

output "servprnc-password" {
  value = ["${var.service_principle_password}"]
}

output "subscription_id" {
  value = ["${var.subscription_id}"]
}

output "tenant_id" {
  value = ["${var.tenant_id}"]
}