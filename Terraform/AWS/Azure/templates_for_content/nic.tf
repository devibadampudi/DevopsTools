resource "azurerm_network_interface" "nic" {
  name                = "tfnic-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_id     = "${azurerm_network_security_group.nsg.id}"


  ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pip.id}"
   }
}