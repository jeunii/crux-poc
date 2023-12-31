module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "7.3.0"

  project_id   = data.tfe_outputs.net-project-gcp.values.net_proj_id
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "node"
      subnet_ip             = "172.19.0.0/22"
      subnet_region         = var.region
      subnet_private_access = "true"
    }
  ]

  secondary_ranges = {
    node = [
      {
        range_name    = "node-reserved"
        ip_cidr_range = "172.19.4.0/22"
      },
      {
        range_name    = "service"
        ip_cidr_range = "172.19.64.0/18"
      },
      {
        range_name    = "service-reserved"
        ip_cidr_range = "172.19.128.0/18"
      },
      {
        range_name    = "pod"
        ip_cidr_range = "172.20.0.0/16"
      },
      {
        range_name    = "pod-reserved"
        ip_cidr_range = "172.21.0.0/16"
      }
    ]
  }
}
