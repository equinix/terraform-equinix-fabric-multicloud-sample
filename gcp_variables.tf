/*
 * Terraform variable declarations for GCP.
 */
variable gcp_credentials_file_path {
  description = "Locate the GCP credentials .json file."
}

variable gcp_project_id {
  description = "GCP Project ID."
}

variable gcp_region {
  description = "Default to Frankfurt region."
}

variable gcp_instance_type {
  description = "Machine Type. Correlates to an network egress cap."
}

variable gcp_disk_image {
  description = "Boot disk for gcp_instance_type."
}

variable gcp_subnet1_cidr {
  description = "A Public Subnets CIDR list for GCP"
}

variable gcp_vm_address {
  description = "Private IP address for GCP VM instance."
}