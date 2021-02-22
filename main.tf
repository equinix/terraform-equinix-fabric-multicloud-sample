/*
 * Terraform main configuration file (with provider definitions).
 */
terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source = "developer.equinix.com/terraform/equinix"
    }
    time = "~> 0.6.0"
  }
}

provider "equinix" {
  client_id       = var.eqx_ecx_client_id
  client_secret   = var.eqx_ecx_client_secret
  request_timeout = 30
}

provider "aws" {
  version = "~> 3.15.0"
  
  shared_credentials_file = pathexpand(var.aws_credentials_file_path)
  region                  = var.aws_region
}

provider "google" {
  version = "~> 3.48.0"

  credentials = file(var.gcp_credentials_file_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}