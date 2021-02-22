# terraform-equinix-fabric-multicloud-sample

### TODO List

- [x] Put all the code in a single directory
- [x] Remove repeated/hardcoded variables
- [ ] move equinx_ne variables values to terraform.tfvars
- [ ] gcp_interconnect convert "null_resource" "export_cloud_router_ip_address" into an external datasource to be able to declare a local variable with the router ip address
- [ ] gcp_interconnect convert "null_resource" "export_customer_router_ip_address" into an
external datasource to be able to declare a local variable with the router ip address