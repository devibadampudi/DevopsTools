resource "oci_core_internet_gateway" "igw" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfigw-${random_id.random_id.hex}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
}