variable "tenancy_ocid" {
  default = ""
}

variable "user_ocid" {
  default = ""
}

variable "fingerprint" {
  default = ""
}

variable "private_key_path" {
  default = "./oci-api-key.pem"
}

variable "region" {
  default = ""
}

variable "compartment_ocid" {
  default = ""
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "image_id" {
  type = "map"
  default = {
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaag2qdx4i2j4h7tn2do5t6dc4yjaj2mc65kvfsgswpfdmfboe6rkoq"
  }
}
variable "sshPublicKey" {
  default = ""
}
variable "VM_user_name" {
  default = "ubuntu"
}
variable "ssh-pvt-key" {
  default = "./instance_pvt_key.pem"
}



