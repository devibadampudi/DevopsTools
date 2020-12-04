resource "oci_core_instance" "instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")}"
  compartment_id      = "${var.compartment_ocid}"
  shape               = "${var.instance_shape}"
  display_name        = "tfinstance-${random_id.random_id.hex}"
  source_details {
    source_id   = "${var.image_id[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.sub.id}"
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = "${var.sshPublicKey}"
  }
}