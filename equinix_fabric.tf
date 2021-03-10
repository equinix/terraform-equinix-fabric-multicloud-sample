/*
 * Terraform Equinix Fabric resources for Equinix.
 */
resource "equinix_ecx_l2_connection_accepter" "aws" {
  connection_id = equinix_ecx_l2_connection.aws.id
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
}

//Retrieve AWS profile id
data "equinix_ecx_l2_sellerprofile" "aws" {
  name = "AWS Direct Connect"
}

resource "equinix_ecx_l2_connection" "aws" {
  name              = var.eqx_fabric_aws_primary_connection_name
  profile_uuid      = data.equinix_ecx_l2_sellerprofile.aws.uuid
  speed             = var.eqx_fabric_aws_speed
  speed_unit        = var.eqx_fabric_aws_speed_unit
  notifications     = var.eqx_fabric_notification_users
  device_uuid       = local.router_id
  seller_region     = var.eqx_fabric_aws_seller_region
  seller_metro_code = var.eqx_fabric_aws_seller_metro_code
  authorization_key = var.eqx_fabric_aws_auth_key
}

//Retrieve GCP profile id
data "equinix_ecx_l2_sellerprofile" "gcp" {
  name = "Google Cloud Partner Interconnect Zone 1"
}

//Create ECX L2 connection
resource "equinix_ecx_l2_connection" "gcp" {
  name              = var.eqx_fabric_gcp_primary_connection_name
  profile_uuid      = data.equinix_ecx_l2_sellerprofile.gcp.uuid
  speed             = var.eqx_fabric_gcp_speed
  speed_unit        = var.eqx_fabric_gcp_speed_unit
  notifications     = var.eqx_fabric_notification_users
  device_uuid       = local.router_id
  seller_region     = var.eqx_fabric_gcp_seller_region
  seller_metro_code = var.eqx_fabric_gcp_seller_metro_code
  authorization_key = google_compute_interconnect_attachment.interconn-vlan.pairing_key // GCP Service Key
}