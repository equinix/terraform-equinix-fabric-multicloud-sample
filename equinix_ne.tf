/*
 * Terraform Network Edge resources for Equinix.
 */
data "equinix_network_device_type" "router" {
  name = "CSR 1000V"
}

resource "equinix_network_device" "router" {
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

resource "equinix_network_ssh_user" "router" {
  username  = var.eqx_ne_ssh_user
  password  = var.eqx_ne_ssh_pwd
  device_ids = [ equinix_network_device.router.id ]
}

resource "equinix_network_bgp" "aws" {
  connection_id       = equinix_ecx_l2_connection.aws.id
  local_ip_address    = var.eqx_ne_bgp_aws_equinix_side_address
  local_asn           = var.eqx_ne_bgp_aws_equinix_side_asn
  remote_ip_address   = cidrhost(var.eqx_ne_bgp_aws_cloud_address,1)
  remote_asn          = 64512 // Default AWS ASN for the Direct Connect Gateway if you don't choose one
  authentication_key  = var.eqx_ne_bgp_aws_auth_key
}

 resource "equinix_network_bgp" "gcp" {
   connection_id      = equinix_ecx_l2_connection.gcp.id
   local_ip_address   = google_compute_interconnect_attachment.interconn-vlan.customer_router_ip_address
   local_asn          = var.eqx_ne_bgp_gcp_equinix_side_asn
   remote_ip_address  = cidrhost(google_compute_interconnect_attachment.interconn-vlan.cloud_router_ip_address,1)
   remote_asn         = 16550 // The Cloud Router used by PARTNER type interconnect attachments must be assigned a local ASN of '16550'
 }