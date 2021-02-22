/*
* Terraform Interconnect resources for GCP.
*/


//Represents an InterconnectAttachment (VLAN attachment) resource.
resource "google_compute_interconnect_attachment" "interconn-vlan" {
  name         = format("%s-interconn-vlan", lower(var.project_name))
  router       = google_compute_router.interconn-router.id
  type         = "PARTNER"
  region       = var.gcp_region
  admin_enabled = true

  edge_availability_domain = "AVAILABILITY_DOMAIN_1" //AVAILABILITY_DOMAIN_ANY - AVAILABILITY_DOMAIN_1 - AVAILABILITY_DOMAIN_2
}

//Represents a Router resource.
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

//Demo Resources
resource "time_sleep" "wait_60_seconds" {
  depends_on = [equinix_ecx_l2_connection.gcp]

  create_duration = "60s"
}

resource "null_resource" "export_cloud_router_ip_address" {
  depends_on = [google_compute_interconnect_attachment.interconn-vlan, time_sleep.wait_60_seconds]
  triggers = {
    interconn-attach = google_compute_interconnect_attachment.interconn-vlan.id
  }
  
  provisioner "local-exec" {
    command = "touch $OUTPUT_FILE && gcp_router_ip_address=`gcloud compute interconnects attachments describe $INTERCONNECT_ATTACHMENT --region=$REGION --project=$PROJECT_ID --format=\"value(cloudRouterIpAddress)\"` && sed -i '/gcp_cloud_router_ip_address/d' $OUTPUT_FILE && echo 'gcp_cloud_router_ip_address = \"'\"$gcp_router_ip_address\"'\"' >> $OUTPUT_FILE"
    
    environment = {
      INTERCONNECT_ATTACHMENT = google_compute_interconnect_attachment.interconn-vlan.name
      OUTPUT_FILE = "${path.module}/../NE_BGP/terraform.tfvars"
      REGION = google_compute_router.interconn-router.region
      PROJECT_ID = var.gcp_project_id
    }
  }
}

resource "null_resource" "export_customer_router_ip_address" {
  depends_on = [google_compute_interconnect_attachment.interconn-vlan, null_resource.export_cloud_router_ip_address]
  
  triggers = {
    interconn-attach = google_compute_interconnect_attachment.interconn-vlan.id
  }
  
  provisioner "local-exec" {
    command = "touch $OUTPUT_FILE && peer_router_ip_address=`gcloud compute interconnects attachments describe $INTERCONNECT_ATTACHMENT --region=$REGION --project=$PROJECT_ID --format=\"value(customerRouterIpAddress)\"` && sed -i '/gcp_customer_router_ip_address/d' $OUTPUT_FILE && echo 'gcp_customer_router_ip_address = \"'\"$peer_router_ip_address\"'\"' >> $OUTPUT_FILE"

    environment = {
      INTERCONNECT_ATTACHMENT = google_compute_interconnect_attachment.interconn-vlan.name
      OUTPUT_FILE = "${path.module}/../NE_BGP/terraform.tfvars"
      REGION = google_compute_router.interconn-router.region
      PROJECT_ID = var.gcp_project_id
    }
  }
}

resource "null_resource" "configure_bgp" {
  depends_on = [equinix_ecx_l2_connection.gcp]

  triggers = {
    peer_asn = var.gcp_bgp_peer_asn
    google_compute_router = google_compute_router.interconn-router.id
  }
  
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]

    command = "peer_name=`gcloud compute routers describe $ROUTER_NAME --region=$REGION --project=$PROJECT_ID --format=\"value(bgpPeers.name)\"` && gcloud compute routers update-bgp-peer $ROUTER_NAME --peer-name=$peer_name --peer-asn=$PEER_ASN --advertisement-mode=CUSTOM --set-advertisement-groups=ALL_SUBNETS --region=$REGION --project=$PROJECT_ID"

    environment = {
      REGION = google_compute_router.interconn-router.region
      ROUTER_NAME = google_compute_router.interconn-router.name
      PROJECT_ID = var.gcp_project_id
      PEER_ASN = var.gcp_bgp_peer_asn
    }
  }
}


