resource "oci_core_route_table" "rt" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfrt-${random_id.random_id.hex}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.igw.id}"
  }
}