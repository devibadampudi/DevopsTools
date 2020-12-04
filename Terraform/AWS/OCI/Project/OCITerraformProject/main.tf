resource "random_id" "unq" {
  keepers     = {}
  byte_length = 2
}

resource "oci_identity_user" "user" {
  name        = "${var.user_name_prefix}${random_id.unq.hex}"
  description = "User managed with Terraform"
}

resource "oci_identity_ui_password" "ui_pwd" {
  user_id = "${oci_identity_user.user.id}"
}

resource "oci_identity_group" "group" {
  name        = "${var.group_name}-${random_id.unq.hex}"
  description = "A group managed with terraform"
}

resource "oci_identity_policy" "policy" {
  name           = "${oci_identity_group.group.name}-policy"
  description    = "automated terraform users policy"
  compartment_id = "${var.compartment_ocid}"

  statements = [
    "Allow group ${oci_identity_group.group.name} to ${var.role} virtual-network-family  in compartment ${var.compartment_name}",
    "Allow group ${oci_identity_group.group.name} to ${var.role} instance-family in compartment ${var.compartment_name}"
  ]
}

resource "oci_identity_user_group_membership" "membership" {
  compartment_id = "${var.compartment_ocid}"
  user_id        = "${oci_identity_user.user.id}"
  group_id       = "${oci_identity_group.group.id}"
}