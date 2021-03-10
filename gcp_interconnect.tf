/*
* Terraform Interconnect resources for GCP.
*/


//GCP InterconnectAttachment (VLAN attachment) resource.
resource "google_compute_interconnect_attachment" "interconn-vlan" {
  name          = format("%s-interconn-vlan", lower(var.project_name))
  router        = google_compute_router.interconn-router.id
  type          = "PARTNER"
  region        = var.gcp_region
  admin_enabled = true

  edge_availability_domain = "AVAILABILITY_DOMAIN_1" //AVAILABILITY_DOMAIN_ANY - AVAILABILITY_DOMAIN_1 - AVAILABILITY_DOMAIN_2
}

//GCP virtual router resource
resource "google_compute_router" "interconn-router" {
  name    = format("%s-interconn-router", lower(var.project_name))
  network = google_compute_network.gcp-network.name
  region  = var.gcp_region
  bgp {
    asn               = 16550 // The Cloud Router used by PARTNER type interconnect attachments must be assigned a local ASN of '16550'
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
 }
}

// [Attention] We use tim_sleep resources for demo purposes
// but they could be a point of failure and we strongly recommend 
// not to use it in production environments
resource "time_sleep" "wait_bgp_config_ready" {
  depends_on = [equinix_ecx_l2_connection.gcp]

  create_duration = "60s"
}

//Resource implementation to complete configuring the bgp session on GCP side 
resource "null_resource" "gcp_configure_bgp" {
  depends_on = [time_sleep.wait_bgp_config_ready]
  triggers = {
    peer_asn              = var.gcp_bgp_equinix_side_asn
    google_compute_router = google_compute_router.interconn-router.id
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "peer_name=`gcloud compute routers describe $ROUTER_NAME --region=$REGION --project=$PROJECT_ID --format=\"value(bgpPeers.name)\"` && gcloud compute routers update-bgp-peer $ROUTER_NAME --peer-name=$peer_name --peer-asn=$PEER_ASN --advertisement-mode=CUSTOM --set-advertisement-groups=ALL_SUBNETS --region=$REGION --project=$PROJECT_ID"
    environment = {
      REGION      = google_compute_router.interconn-router.region
      ROUTER_NAME = google_compute_router.interconn-router.name
      PROJECT_ID  = var.gcp_project_id
      PEER_ASN    = var.gcp_bgp_equinix_side_asn
    }
  }
}

// [Attention] Data source implementation to obtain the IPs of the routers associated
// with the interconnect attachment
// Although they can be obtained with the google_compute_interconnect_attachment resource,
// it generally returns an empty value during the first execution,
// in this way we can wait until we have the value of the IPs
data "external" "export_gcp_interconn_attachment_ips" {
  depends_on = [null_resource.gcp_configure_bgp]

  program = ["/bin/bash", "get_interconnect_attachment_ips.sh"]

  query = {
      interconnect_name = google_compute_interconnect_attachment.interconn-vlan.name
      region            = google_compute_interconnect_attachment.interconn-vlan.region
      project_id        = var.gcp_project_id
  }
}

locals {
 gcp_bgp_equinix_side_address = data.external.export_gcp_interconn_attachment_ips.result.customer_router_ip
 gcp_bgp_cloud_address = data.external.export_gcp_interconn_attachment_ips.result.cloud_router_ip
}
