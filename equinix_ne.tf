/*
 * Terraform Network Edge resources for Equinix.
 */
data "equinix_network_device_type" "router" {
  name = "CSR 1000V"
}

resource "equinix_network_device" "router" {
  count             = var.eqx_ne_create_ne_device ? 1 : 0

  name              = var.eqx_ne_device_name
  type_code         = data.equinix_network_device_type.router.code
  hostname          = var.eqx_ne_device_hostname
  byol              = false
  metro_code        = var.eqx_ne_device_metro_code
  notifications     = var.eqx_fabric_notification_users
  package_code      = var.eqx_ne_device_package_code
  term_length       = var.eqx_ne_device_term_length
  throughput        = var.eqx_ne_device_throughput
  throughput_unit   = var.eqx_ne_device_throughput_unit
  account_number    = var.eqx_ne_account_number
  interface_count   = var.eqx_ne_device_interface_count
  core_count        = var.eqx_ne_device_core_count
  version           = var.eqx_ne_device_version
  self_managed      = false
}

locals {
  router_id = var.eqx_ne_create_ne_device ? equinix_network_device.router[0].id : var.eqx_ne_device_id
}

resource "equinix_network_ssh_user" "router" {
  count = var.eqx_ne_create_ne_device ? 1 : 0

  username  = var.eqx_ne_ssh_user
  password  = var.eqx_ne_ssh_pwd
  device_ids = [ local.router_id ]
}

resource "equinix_network_bgp" "aws" {
  connection_id       = equinix_ecx_l2_connection.aws.id
  local_ip_address    = var.aws_dx_bgp_equinix_side_address
  local_asn           = var.aws_dx_bgp_equinix_side_asn
  remote_ip_address   = cidrhost(var.aws_dx_bgp_amazon_address,1)
  remote_asn          = 64512 // Default AWS ASN for the Direct Connect Gateway if you don't choose one
  authentication_key  = var.aws_dx_bgp_authkey
}

resource "equinix_network_bgp" "gcp" {
  connection_id      = equinix_ecx_l2_connection.gcp.id
  local_ip_address   = local.gcp_bgp_equinix_side_address
  local_asn          = var.gcp_bgp_equinix_side_asn
  remote_ip_address  = cidrhost(local.gcp_bgp_cloud_address,1)
  remote_asn         = 16550 // The Cloud Router used by PARTNER type interconnect attachments must be assigned a local ASN of '16550'
}
