data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}
resource "oci_core_subnet" "sub" {
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "tfsub${random_id.random_id.hex}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")}"
  cidr_block          = "10.0.1.0/24"
  route_table_id      = "${oci_core_route_table.rt.id}"
  security_list_ids   = ["${oci_core_security_list.seclist.id}"]
  vcn_id              = "${oci_core_virtual_network.vcn.id}"
}