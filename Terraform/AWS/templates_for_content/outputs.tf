output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}
output "vm_username" {
  value = "${var.VM_user_name}"
}
