resource "azurerm_virtual_machine" "vm" {
  name                  = "tfvm-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "Basic_A1"
  # vm_size               = "Standard_B1s"  
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "tfazureosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "tfazure-vm"
    admin_username = "${var.VM_user_name}"
    admin_password = "${var.VM_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}