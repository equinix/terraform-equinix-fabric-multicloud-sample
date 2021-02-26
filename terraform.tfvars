project_name    = "Equinix-Demo"
owner           = "Me"

// AWS variables
aws_access_key              = "" //AWS access key
aws_secret_key              = "" //AWS secrets key
aws_region                  = "eu-central-1"
aws_instance_type           = "t3.micro"
aws_disk_image              = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
aws_network_cidr            = "172.16.0.0/16"
aws_subnet1_cidr            = "172.16.0.0/24"
aws_vm_address              = "172.16.0.100"
aws_dx_bgp_asn              = "65432"
aws_dx_bgp_authkey          = "Vz8PmPjOvq"
aws_dx_bgp_amazon_address   = "169.254.237.17/30"
aws_dx_bgp_customer_address = "169.254.237.18/30"
aws_ssh_key_name            = "" //SSH key to access to the AWS VM. It must be created before running this example in AWS
// GCP variables
gcp_credentials_file_path   = "" //Google Cloud path to credentials json file Ex. "/home/me/gcp/gcp.json"
gcp_project_id              = "" //Google Cloud existing project ID Ex. "my-project"
gcp_subnet1_cidr            = "10.240.0.0/24"
gcp_vm_address              = "10.240.0.100"
gcp_region                  = "europe-west3"
gcp_instance_type           = "n1-standard-1"
gcp_disk_image              = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts"

// Equinix variables
eqx_fabric_notification_users   = [""] //["example@equinix.com"]
eqx_fabric_client_id            = "" //Equinix Fabric Consumer Key (API credentials from https://developer.equinix.com/)
eqx_fabric_client_secret        = "" //Equinix Fabric Consumer Secret (API credentials from https://developer.equinix.com/)
// AWS connection
eqx_fabric_aws_primary_connection_name  = "DEMO_EF_AWS"
eqx_fabric_aws_auth_key                 = "" //The AWS Account ID you want to connect to
eqx_fabric_aws_seller_region            = "eu-central-1"
eqx_fabric_aws_seller_metro_code        = "FR"
eqx_fabric_aws_speed                    = "50"
eqx_fabric_aws_speed_unit               = "MB"
// GCP connection
eqx_fabric_gcp_primary_connection_name  = "DEMO_EF_GCP"
eqx_fabric_gcp_seller_region            = "europe-west3"
eqx_fabric_gcp_seller_metro_code        = "FR"
eqx_fabric_gcp_speed                    = "100"
eqx_fabric_gcp_speed_unit               = "MB"
// NE Device
eqx_ne_device_name              = "My-Router1"
eqx_ne_device_hostname          = "Router1"
eqx_ne_device_metro_code        = "FR"
eqx_ne_device_package_code      = "APPX"
eqx_ne_device_term_length       = 1
eqx_ne_device_throughput        = 500
eqx_ne_device_throughput_unit   = "Mbps"
eqx_ne_account_number           = "155225"
eqx_ne_device_interface_count   = 10
eqx_ne_device_core_count        = 2
eqx_ne_device_version           = "16.09.05"
eqx_ne_ssh_user                 = "my-ssh-user"
eqx_ne_ssh_pwd                  = "my-ssh-pass"
// BGP AWS
eqx_ne_bgp_aws_equinix_side_address = "169.254.237.18/30"
eqx_ne_bgp_aws_equinix_side_asn     = 65432
eqx_ne_bgp_aws_cloud_address        = "169.254.237.17/30"
eqx_ne_bgp_aws_auth_key             = "Vz8PmPjOvq"
// BGP GCP
eqx_ne_bgp_gcp_equinix_side_asn     = 64538