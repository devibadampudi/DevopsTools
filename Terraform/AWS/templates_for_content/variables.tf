variable "access_key" {
   default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = ""
}
variable "ssh-pub-key"{
    default = ""
}

variable "VM_user_name" {
  default = "ubuntu"
}
variable "ssh-pvt-key" {
  default = "./instance-pvt-key.pem"
}

