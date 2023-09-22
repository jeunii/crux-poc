module "vpn_ha-1" {
  source            = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version           = "~> 1.3.0"
  project_id        = data.tfe_outputs.net-project-gcp.values.net_proj_id
  region            = var.region
  network           = data.tfe_outputs.network-gcp.values.shared_vpc_name
  name              = "gcp-to-on-prem"
  peer_gcp_gateway  = module.vpn_ha-2.self_link
  router_asn        = 64514

  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = var.secret
    }

    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = var.secret
    }

  }
}

module "vpn_ha-2" {
  source              = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version             = "~> 1.3.0"
  project_id          = data.tfe_outputs.net-project-on-prem.values.net_proj_id
  region              = "europe-west4"
  network             = data.tfe_outputs.network-on-prem.values.shared_vpc_name
  name                = "net2-to-net1"
  router_asn          = 64513
  peer_gcp_gateway    = module.vpn_ha-1.self_link

  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.2"
        asn     = 64514
      }
      bgp_session_range               = "169.254.1.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      shared_secret                   = var.secret
    }

    remote-1 = {
      bgp_peer = {
        address = "169.254.2.2"
        asn     = 64514
      }
      bgp_session_range               = "169.254.2.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      shared_secret                   = var.secret
    }

  }
}