resource "null_resource" "install_apache" {
  connection {
    type        = "ssh"
    host        = "${aws_instance.instance.public_ip}"
    user        = "${var.VM_user_name}"
    private_key = "${(file(var.ssh-pvt-key))}"
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