/*
 * Terraform security resources for AWS.
 */
# Allow PING testing.
resource "aws_security_group" "aws-allow-icmp" {
  name        = "aws-allow-icmp"
  description = "Allow icmp access from anywhere"
  vpc_id      = aws_vpc.aws-vpc.id

  ingress {
    from_port   = 8
    to_port     = 8
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Project   = lower(var.project_name)
  }
}

# Allow SSH for iperf testing.
resource "aws_security_group" "aws-allow-ssh" {
  name        = "aws-allow-ssh"
  description = "Allow ssh access from anywhere"
  vpc_id      = aws_vpc.aws-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Project   = lower(var.project_name)
    Owner     = lower(var.owner)
  }
}

# Allow traffic from the CSPs subnets.
resource "aws_security_group" "aws-allow-csps" {
  name        = "aws-allow-csps"
  description = "Allow all traffic from other CSPs resources"
  vpc_id      = aws_vpc.aws-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.gcp_subnet1_cidr]
  }
}

# Allow Iperf and Flask traffic from the Internet.
resource "aws_security_group" "aws-allow-internet" {
  name        = "aws-allow-internet"
  description = "Allow http traffic from the internet"
  vpc_id      = aws_vpc.aws-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Project   = lower(var.project_name)
    Owner     = lower(var.owner)
  }
}

