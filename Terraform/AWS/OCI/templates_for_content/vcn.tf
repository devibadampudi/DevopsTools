resource "random_id" "random_id" {
  byte_length = 2
}

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  dns_label      = "tfdnslabel"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfvnet-${random_id.random_id.hex}"
}
