/*
 * Terraform variable declarations for Equinix Fabric.
 */

variable eqx_fabric_client_id {
  
  description = "Equinix Fabric Developer API client ID"
}

variable eqx_fabric_client_secret {
  
  description = "Equinix Fabric Developer API client Secret"
}

variable eqx_fabric_notification_users {
  type    = list(string)
}

variable eqx_fabric_aws_primary_connection_name {
  description = "Equinix Fabric connection name"
}

variable eqx_fabric_aws_speed {
  description = "speed for the Equinic Fabric connection, must be allowed by the platform and seller"
}

variable eqx_fabric_aws_speed_unit {
  description = "MB / GB, must be allowed by the platform and the seller"
}

variable eqx_fabric_aws_port_name {
  default = ""
}

variable eqx_fabric_aws_vlan_stag {
  description = "Equinix Fabric side VLAN for the specific connection (primary connection)"
  default     = ""
}

variable eqx_fabric_aws_seller_region {
  descritpion = ""
}

variable eqx_fabric_aws_seller_metro_code {
  description = "Seller metro to connect to"
}

variable eqx_fabric_aws_auth_key {
  description = "AWS Account ID"
}

variable eqx_fabric_gcp_primary_connection_name {
  
}

variable eqx_fabric_gcp_speed {
  
  description = "speed for the NE connection, must be allowed by the platform and seller"
}

variable eqx_fabric_gcp_speed_unit {
  description = "MB / GB, must be allowed by the platform and the seller"
}

variable eqx_fabric_gcp_seller_region {
}

variable eqx_fabric_gcp_seller_metro_code {
  description = "Seller metro to connect to"
}

/*
 * Terraform variable declarations for Equinx Network Edge.
 */
variable eqx_ne_account_number {
  description = ""
}

variable eqx_ne_device_name {
  description = "Equinix Network Edge device name"
}

variable eqx_ne_device_hostname {
  description = ""
}

variable eqx_ne_device_metro_code {
  description = ""
}

variable eqx_ne_device_package_code {
  description = ""
}

variable eqx_ne_device_term_length {
  description = ""
}

variable eqx_ne_device_throughput {
  description = ""
}

variable eqx_ne_device_throughput_unit {
  description = ""
}

variable eqx_ne_device_interface_count {
  description = ""
}

variable eqx_ne_device_core_count {
  description = ""
}

variable eqx_ne_device_version {
  description = ""
}

variable eqx_ne_ssh_user {
  description = ""
}

variable eqx_ne_ssh_pwd {
  description = ""
}

variable eqx_ne_bgp_gcp_equinix_side_asn {
  description = ""
}

variable eqx_ne_bgp_aws_equinix_side_asn {
  description = ""
}

variable eqx_ne_bgp_aws_auth_key {
  description = ""
}

variable eqx_ne_bgp_aws_cloud_address {
  description = ""
}

variable eqx_ne_bgp_aws_equinix_side_address {
  description = ""
}