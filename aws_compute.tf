/*
 * Terraform compute resources for AWS.
 */
data "aws_ami" "aws-ami-ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.aws_disk_image]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_eip" "aws-ip" {
  vpc = true

  instance                  = aws_instance.aws-vm.id
  associate_with_private_ip = var.aws_vm_address
}

resource "aws_instance" "aws-vm" {
  ami                         = data.aws_ami.aws-ami-ubuntu.id
  instance_type               = var.aws_instance_type
  subnet_id                   = aws_subnet.aws-subnet-1.id
  key_name                    = var.aws_ssh_key_name
  associate_public_ip_address = true
  private_ip                  = var.aws_vm_address

  vpc_security_group_ids = [
    aws_security_group.aws-allow-icmp.id,
    aws_security_group.aws-allow-ssh.id,
    aws_security_group.aws-allow-internet.id,
    aws_security_group.aws-allow-csps.id,
  ]

  user_data = replace(
    file("vm_userdata.sh"),
    "<INT_IP>",
    var.gcp_vm_address,
  )

  tags = {
    Name      = "aws-vm-${var.aws_region}"
    Terraform = "true"
    Project   = lower(var.project)
    Owner     = lower(var.owner)
  }
}


