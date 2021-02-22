/*
 * Terraform networking resources for AWS.
 */
resource "time_sleep" "wait_accepter_30_seconds" {
  depends_on = [equinix_ecx_l2_connection_accepter.aws]

  create_duration = "30s"
}

resource "aws_vpc" "aws-vpc" {
  depends_on = [time_sleep.wait_accepter_30_seconds]

  cidr_block           = var.aws_network_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name       = format("%s-VPC", upper(var.owner))
    Terraform  = "true"
    Project    = lower(var.project)
    Owner      = lower(var.owner)
  }
}

resource "aws_subnet" "aws-subnet-1" {
  vpc_id     = aws_vpc.aws-vpc.id
  cidr_block = var.aws_subnet1_cidr

  tags = {
    Name = "aws-vpn-subnet"
    Terraform  = "true"
    Project    = lower(var.project)
    Owner      = lower(var.owner)
  }
}

resource "aws_internet_gateway" "aws-vpc-igw" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name = "aws-vpc-igw"
    Terraform  = "true"
    Project    = lower(var.project)
    Owner      = lower(var.owner)
  }
}

resource "aws_default_route_table" "aws-vpc" {
  default_route_table_id = aws_vpc.aws-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-vpc-igw.id
  }

  propagating_vgws = [ aws_vpn_gateway.aws-dx.id ]
}

