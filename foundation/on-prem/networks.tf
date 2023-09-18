module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = module.host_project.project_id
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.255.252.0/22"
      subnet_region         = var.region
      subnet_private_access = "false"
    },
  ]
}

resource "google_compute_router" "router" {
  name    = "${module.vpc.subnets_regions[0]}-router"
  region  = module.vpc.subnets_regions[0]
  network = module.vpc.network_name
  project = module.vpc.project_id
  bgp {
    asn = "65002"
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

resource "google_compute_router_interface" "interface_0" {
  project    = module.vpc.project_id
  name       = "interface-0"
  router     = google_compute_router.router.name
  region     = var.region
  ip_range   = "169.254.1.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnels_0.id
}

resource "google_compute_router_interface" "interface_1" {
  project    = module.vpc.project_id
  name       = "interface-1"
  router     = google_compute_router.router.name
  region     = var.region
  ip_range   = "169.254.2.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnels_1.id
}

resource "google_compute_router_peer" "peer_0" {
  project                   = module.vpc.project_id
  name                      = "my-router-peer-0"
  router                    = google_compute_router.router.name
  region                    = var.region
  peer_ip_address           = "169.254.1.1"
  peer_asn                  = 65001
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.interface_0.name
}

resource "google_compute_router_peer" "peer_1" {
  project                   = module.vpc.project_id
  name                      = "my-router-peer-1"
  router                    = google_compute_router.router.name
  region                    = var.region
  peer_ip_address           = "169.254.2.1"
  peer_asn                  = 65001
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.interface_1.name
}
