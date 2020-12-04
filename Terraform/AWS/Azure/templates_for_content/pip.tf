resource "azurerm_public_ip" "pip" {
  name                = "tfpip-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  allocation_method   = "Static"
}