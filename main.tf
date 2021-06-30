/*
 * Terraform main configuration file (with provider definitions).
 */
terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.1.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.15.0"
    }
    google = {
      source = "hashicorp/google"
      version = "~> 3.48.0"
    }
    time = "~> 0.6.0"
  }
}

provider "equinix" {
  client_id       = var.eqx_fabric_client_id
  client_secret   = var.eqx_fabric_client_secret
  request_timeout = 30
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

provider "google" {
  credentials = file(var.gcp_credentials_file_path)
  project     = var.gcp_project_id
  region      = var.gcp_region
}