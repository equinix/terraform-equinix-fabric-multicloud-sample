/*
 * Terraform output variables for GCP.
 */

output "gcp_instance_external_ip" {
 value = google_compute_instance.gcp-vm.network_interface[0].access_config[0].nat_ip
}

output "gcp_instance_internal_ip" {
 value = google_compute_instance.gcp-vm.network_interface[0].network_ip
}

output "gcp_cloud_router_ip_address" {
 value = google_compute_interconnect_attachment.interconn-vlan.cloud_router_ip_address
}

output "gcp_customer_router_ip_address" {
 value = google_compute_interconnect_attachment.interconn-vlan.customer_router_ip_address
}

