module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "7.3.0"

  project_id   = data.tfe_outputs.projects-gcp.values
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.0.0.0/20"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "192.168.0.0/22"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-03"
      subnet_ip             = "192.168.4.0/22"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "cloud-function-connector"
      subnet_ip             = "192.168.255.240/28"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-pods"
        ip_cidr_range = "10.4.0.0/14"
      },
      {
        range_name    = "subnet-01-secondary-svc-01"
        ip_cidr_range = "10.8.0.0/14"
      },
    ]
    subnet-02 = [
      {
        range_name    = "subnet-02-secondary-pods"
        ip_cidr_range = "10.12.0.0/14"
      },
      {
        range_name    = "subnet-02-secondary-svc-01"
        ip_cidr_range = "10.16.0.0/14"
      },
    ]
    subnet-03 = [
      {
        range_name    = "subnet-03-secondary-pods"
        ip_cidr_range = "10.20.0.0/14"
      },
      {
        range_name    = "subnet-03-secondary-svc-01"
        ip_cidr_range = "10.24.0.0/14"
      },
    ]
  }
}
