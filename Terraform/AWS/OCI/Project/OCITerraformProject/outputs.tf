
output "USERNAME" {
  value = ["${oci_identity_user.user.name}"]
}

output "PASSWORD" {
  value = ["${oci_identity_ui_password.ui_pwd.password}"]
}

output "tenancy_ocid" {
  value = ["${var.tenancy_ocid}"]
}

output "user_ocid" {
  value = ["${oci_identity_user.user.id}"]
}

output "region" {
  value = ["${var.ociregion}"]
}

output "compartment_name" {
  value = ["${var.compartment_name}"]
}

output "compartment_ocid" {
  value = ["${var.compartment_ocid}"]
}

output "tenancy_name" {
  value = ["${var.tenancy_name}"]
}



