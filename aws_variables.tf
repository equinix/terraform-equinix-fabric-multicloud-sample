/*
 * Terraform variable declarations for AWS.
 */
variable aws_access_key {
  description = "AWS access key"
}

variable aws_secret_key {
  description = "AWS secret key"
}

variable aws_region {
  description = "Default to Frankfurt region."
}

variable aws_instance_type {
  description = "Machine Type. Includes 'Enhanced Networking' via ENA."
}

variable aws_disk_image {
  description = "Boot disk for gcp_instance_type."
}

variable aws_network_cidr {
  description = "VPC network ip block."
}

variable aws_subnet1_cidr {
  description = "Subset block from VPC network ip block."
}

variable aws_vm_address {
  description = "Private IP address for AWS VM instance."
}

variable aws_ssh_key_name {
  description = "SSH key to access to the AWS VM"
}

variable aws_dx_bgp_equinix_side_asn {
  description = "The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration. Each BGP interface may use a different value. (Equinix side)"
}

variable aws_dx_bgp_authkey {
  description = "The authentication key for BGP configuration. Special characters may conflict in the router configuration"
}

variable aws_dx_bgp_amazon_address {
  description = "The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers"
}

variable aws_dx_bgp_equinix_side_address {
  description = "The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers (Equinix side)"
}