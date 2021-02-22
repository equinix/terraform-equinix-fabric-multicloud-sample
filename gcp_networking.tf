/*
 * Terraform networking resources for GCP.
 */

resource "google_compute_network" "gcp-network" {
  name                    = format("%s-gcp-network", lower(var.project_name))
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "gcp-subnet-1" {
  name          = format("%s-gcp-subnet-1", lower(var.project_name))
  ip_cidr_range = var.gcp_subnet1_cidr
  network       = google_compute_network.gcp-network.name
  region        = var.gcp_region
}
