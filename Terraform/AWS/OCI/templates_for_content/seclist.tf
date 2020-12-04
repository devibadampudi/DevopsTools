resource oci_core_security_list "seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfseclist${random_id.random_id.hex}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
       max = "80"
        min = "80"

    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
        max = "22"
        min = "22"

    }
  }

}