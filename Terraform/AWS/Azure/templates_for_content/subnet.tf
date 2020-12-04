resource "azurerm_subnet" "subnet" {
  name                 = "tfsubnet-${random_id.random_id.hex}"
  resource_group_name = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.0.0/24"
}