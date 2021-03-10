/*
 * Terraform connect resources for AWS.
 */
resource "aws_vpn_gateway" "aws-dx" {
  tags = {
    Terraform = "true"
    Project   = lower(var.project_name)
    Owner     = lower(var.owner)
  }
}

resource "aws_vpn_gateway_attachment" "aws-dx" {
  vpc_id          = aws_vpc.aws-vpc.id
  vpn_gateway_id  = aws_vpn_gateway.aws-dx.id
}

resource "time_sleep" "wait_vif_ready" {
  depends_on = [aws_instance.aws-vm]

  create_duration = "120s"
}

resource "aws_dx_private_virtual_interface" "aws-dx" {
  depends_on = [time_sleep.wait_vif_ready]

  connection_id     = equinix_ecx_l2_connection_accepter.aws.aws_connection_id
  name              = format("%s-dx-vif", lower(var.project_name))
  vlan              = equinix_ecx_l2_connection.aws.zside_vlan_stag // Corresponds to the Equinix API parameter 'Seller-Side VLAN ID - zside_vlan_stag'
  address_family    = "ipv4"
  bgp_asn           = tostring(var.aws_dx_bgp_equinix_side_asn)
  bgp_auth_key      = var.aws_dx_bgp_authkey
  amazon_address    = var.aws_dx_bgp_amazon_address
  customer_address  = var.aws_dx_bgp_equinix_side_address
  vpn_gateway_id    = aws_vpn_gateway.aws-dx.id

  tags = {
    Terraform = "true"
    Project   = lower(var.project_name)
    Owner     = lower(var.owner)
  }

  timeouts {
    create = "30m"
    delete = "30m"
  }
}