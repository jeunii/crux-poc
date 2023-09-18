module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = module.host_project.project_id
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

resource "google_compute_router" "router" {
  name    = "${module.vpc.subnets_regions[0]}-router"
  region  = module.vpc.subnets_regions[0]
  network = module.vpc.network_name
  project = module.vpc.project_id
  bgp {
    asn = "65001"
  }
}

resource "google_compute_ha_vpn_gateway" "ha_gateway" {
  region  = var.region
  project = module.vpc.project_id
  name    = "${module.vpc.subnets_regions[0]}-gtw"
  network = module.vpc.network_id
}

resource "google_compute_vpn_tunnel" "tunnels_0" {
  project               = module.vpc.project_id
  region                = var.region
  name                  = "${var.tunnel_name}-0"
  shared_secret         = var.shared_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway.id
  vpn_gateway_interface = "0"
  peer_gcp_gateway      = var.peer_gateway
  router                = google_compute_router.router.self_link
}

resource "google_compute_vpn_tunnel" "tunnels_1" {
  project               = module.vpc.project_id
  region                = var.region
  name                  = "${var.tunnel_name}-1"
  shared_secret         = var.shared_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway.id
  vpn_gateway_interface = "1"
  peer_gcp_gateway      = var.peer_gateway
  router                = google_compute_router.router.self_link
}
resource "google_compute_global_address" "peering_redis" {
  name          = "redis-peering-cidr"
  address       = "10.64.0.0"
  purpose       = "VPC_PEERING"
  prefix_length = "16"
  address_type  = "INTERNAL"
  network       = module.vpc.network_id
  project       = module.host_project.project_id
}

resource "google_compute_global_address" "peering_postresql" {
  name          = "postresql-peering-cidr"
  address       = "10.128.0.0"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = "16"
  network       = module.vpc.network_id
  project       = module.host_project.project_id
}

resource "google_service_networking_connection" "peering_svc" {
  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.peering_redis.name, google_compute_global_address.peering_postresql.name]
}

resource "google_compute_router_interface" "interface_0" {
  project    = module.vpc.project_id
  name       = "interface-0"
  router     = google_compute_router.router.name
  region     = var.region
  ip_range   = "169.254.1.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnels_0.id
}

resource "google_compute_router_interface" "interface_1" {
  project    = module.vpc.project_id
  name       = "interface-1"
  router     = google_compute_router.router.name
  region     = var.region
  ip_range   = "169.254.2.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnels_1.id
}

resource "google_compute_router_peer" "peer_0" {
  project                   = module.vpc.project_id
  name                      = "my-router-peer-0"
  router                    = google_compute_router.router.name
  region                    = var.region
  peer_ip_address           = "169.254.1.2"
  peer_asn                  = 65002
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.interface_0.name
}

resource "google_compute_router_peer" "peer_1" {
  project                   = module.vpc.project_id
  name                      = "my-router-peer-1"
  router                    = google_compute_router.router.name
  region                    = var.region
  peer_ip_address           = "169.254.2.2"
  peer_asn                  = 65002
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.interface_1.name
}

resource "google_compute_global_address" "psc_ip" {
  project      = module.vpc.project_id
  name         = "global-psconnect-ip"
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = module.vpc.network_name
  address      = "10.255.255.1"
}

resource "google_compute_global_forwarding_rule" "default" {
  project               = module.vpc.project_id
  name                  = "globalrule"
  target                = "all-apis"
  network               = module.vpc.network_name
  ip_address            = google_compute_global_address.psc_ip.address
  load_balancing_scheme = ""
}
