variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "ociregion" {}

variable "user_name_prefix" {
  default = "qldtluser"
}

variable "group_name" {
  default = "tl_users_group"
}

variable "compartment_ocid" {}

variable "compartment_name" {}

variable "role" {
    default = "manage"
}

variable "tenancy_name" {}
