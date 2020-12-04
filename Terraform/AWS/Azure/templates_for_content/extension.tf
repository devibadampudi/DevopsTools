resource "null_resource" "install_apache" {
  connection {
    type     = "ssh"
    host     = "${azurerm_public_ip.pip.ip_address}"
    user     = "${var.VM_user_name}"
    password = "${var.VM_password}"
  }
  provisioner "file" {
    source      = "./apache-install.sh"
    destination = "/home/${var.VM_user_name}/apache-install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.VM_user_name}/apache-install.sh",
      "cd /home/${var.VM_user_name}/",
      "./apache-install.sh >> remote-exec.log"
    ]
  }
}