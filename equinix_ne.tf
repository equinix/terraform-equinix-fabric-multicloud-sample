/*
 * Terraform Network Edge resources for Equinix.
 */
data "equinix_network_device_type" "router" {
  name = "CSR 1000V"
}

resource "equinix_network_device" "router" {
  name              = var.eqx_ne_device_name // "OSCAR-BT-DEMO"
  type_code         = data.equinix_network_device_type.router.code
  hostname          = var.eqx_ne_device_hostname //"BT-Device"
  byol              = false
  metro_code        = var.eqx_ne_device_metro_code //"FR"
  notifications     = var.eqx_fabric_notification_users
  package_code      = var.eqx_ne_device_package_code //"APPX"
  term_length       = var.eqx_ne_device_term_length //1
  throughput        = var.eqx_ne_device_throughput //500
  throughput_unit   = var.eqx_ne_device_throughput_unit //"Mbps"
  account_number    = var.eqx_ne_account_number //"155225"
  interface_count   = var.eqx_ne_device_interface_count //10
  core_count        = var.eqx_ne_device_core_count //2
  version           = var.eqx_ne_device_version //"16.09.05"
  self_managed      = false
}

resource "equinix_network_ssh_user" "router" {
  username  = var.eqx_ne_ssh_user //"bti-tf-r99"
  password  = var.eqx_ne_ssh_pwd // "bti-tf-r99"
  device_ids = [ equinix_network_device.router.id ]
}

resource "equinix_network_bgp" "aws" {
  connection_id       = equinix_ecx_l2_connection.aws.id
  local_ip_address    = var.eqx_ne_bgp_aws_equinix_side_address
  local_asn           = var.eqx_ne_bgp_aws_equinix_side_asn //65432
  remote_ip_address   = cidrhost(var.eqx_ne_bgp_aws_cloud_address,1)
  remote_asn          = 64512 // Default AWS ASN for the Direct Connect Gateway if you don't choose one
  authentication_key  = var.eqx_ne_bgp_aws_auth_key // "Vz8PmPjOvq"
}

resource "equinix_network_bgp" "gcp" {
  connection_id       =  equinix_ecx_l2_connection.gcp.id
  local_ip_address    = local.eqx_ne_bgp_gcp_equinix_side_address
  local_asn           = var.eqx_ne_bgp_gcp_equinix_side_asn //64538
  remote_ip_address   = cidrhost(local.eqx_ne_bgp_gcp_cloud_address,1)
  remote_asn          = 16550 // The Cloud Router used by PARTNER type interconnect attachments must be assigned a local ASN of '16550'
}