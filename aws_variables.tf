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

variable aws_create_dx_pvi {
}

variable aws_dx_address_familiy {
}

variable aws_dx_bgp_asn {
}

variable aws_dx_bgp_authkey {
}

variable aws_dx_bgp_amazon_address {
  description = "The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers"
}

variable aws_dx_bgp_customer_address {
  description = "The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers"
}