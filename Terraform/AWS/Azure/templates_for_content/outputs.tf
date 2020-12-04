output "VM_public_ip_address" {
  value = ["${azurerm_public_ip.pip.ip_address}"]
}
output "VM_username" {
  value = ["${var.VM_user_name}"]
}
output "VM_password" {
  value = ["${var.VM_password}"]
}