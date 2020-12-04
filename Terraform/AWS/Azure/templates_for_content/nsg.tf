resource "azurerm_network_security_group" "nsg" {
  name                = "tfnsg-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
}