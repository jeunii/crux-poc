module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "7.3.0"

  project_id   = data.tfe_outputs.net-project-on-prem.values.net_proj_id
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "node"
      subnet_ip             = var.onprem_node_ip_range
      subnet_region         = var.region
      subnet_private_access = "true"
    }
  ]

  ingress_rules	= [
    {
      name = "ingress-allow-all-internal"
      description = "Allow all communication b/w internal nodes"
      source_ranges = [var.onprem_node_ip_range]
      allow = [
        {
          protocol = "tcp"
        },
        {
          protocol = "udp"
        },
        {
          protocol = "icmp"
        },
        {
          protocol = "ipip"
        }
      ]
    },
    {
      name = "ingress-allow-external"
      description = "Allow selected communication from external"
      source_ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports = ["22", "6443"]
        },
        {
          protocol = "icmp"
        },
      ]
    },
  ]
}


resource "google_compute_address" "k8s-master-internal-ip" {
  name         = "k8s-master-internal-ip"
  project_id   = data.tfe_outputs.net-project-on-prem.values.net_proj_id
  subnetwork   = module.vpc.subnets_ids[0]
  address_type = "INTERNAL"
  region       = var.region
}


resource "google_compute_address" "k8s-master-external-ip" {
  name         = "k8s-master-external-ip"
  project_id   = data.tfe_outputs.net-project-on-prem.values.net_proj_id
}