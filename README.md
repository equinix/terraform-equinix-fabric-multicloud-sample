# terraform-equinix-fabric-multicloud-sample

This lab aims to demonstrate how using the terraform Equinix provider, in conjunction with the AWS provider and Google provider, you can fully automate the entire process of establishing a secure, direct connection between multiple clouds.

After completing the lab you will be able to communicate from an virtual machine in AWS (EC2 instance) to a virtual machine in Google Cloud using private addressing.

![Multi-cloud automation Equinix Fabric diagram](docs/images/Multicloud-Automation-Equinix-Fabric-Diagram.PNG?raw=true "Multi-cloud automation Equinix Fabric diagram")


---

## Requirements

* Equinix Fabric Account:
** Permission to create Connection and Network Edge devices
* GCP Account: 
** Permission to create a project or select one already created
** Enable billing.
** Enable APIs: Compute Engine API, and Cloud Deployment Manager API.
* AWS Account:
** Permission to access IAM Resources and create an access key
** IAM user with EC2 full access
* Curently, this demo only works on Linux. If you do not have access to a Linux environment, we recommend using the GCP cloud shell since it already includes other dependencies listed below.

## Setup

Required steps to setup your environment for the lab:

* Install the developer version of the terraform Equinix provider. Check [Equinix provider development](https://github.com/equinix/terraform-provider-equinix/blob/master/DEVELOPMENT.md) for guides on building the provider.
* Install and setup Google Cloud SDK [Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install)). Skip this step if you are using Google cloud shell.
* Create or import a key pair into AWS [AWS Create or import a key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#prepare-key-pair)

## Usage

1. Clone this project

   ```sh
   mkdir -p $HOME/Workspace/equinix; cd $HOME/Workspace/equinix
   git clone https://github.com/equinix/terraform-equinix-fabric-multicloud-sample.git
   ```
2. Enter provider directory and use your text editor to set the required parameters. Only the ones with no default value are necessary, the others can be left as is.

   ```sh
   cd terraform-equinix-fabric-multicloud-sample
   vim terraform.tfvars

3. From the provider directory execute terraform

   ```sh
   terraform init
   terraform plan
   terraform apply -y

4. SSH login in one of the instances and run iperf to test the connection

   ```sh
   ssh -i ~/.ssh/vm-ssh-key [VM_EXTERNAL_IP]
   bash /tmp/run_iperf_to_int.sh
   
## TODO - Pending tasks

- [ ] Add variables validation