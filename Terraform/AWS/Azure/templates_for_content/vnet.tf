resource "random_id" "random_id" {
  byte_length = 2
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tfvnet-${random_id.random_id.hex}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
}