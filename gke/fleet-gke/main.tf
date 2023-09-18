module "kubernetes_engine" {
  source = "../../terraform-google-kubernetes-engine//modules/beta-private-cluster"

  project_id                  = data.tfe_outputs.cloud.values.fleet_project_id
  name                        = var.name
  regional                    = var.regional
  region                      = var.region
  network                     = data.tfe_outputs.cloud.values.vpc_name
  network_project_id          = data.tfe_outputs.cloud.values.host_project_id
  subnetwork                  = data.tfe_outputs.cloud.values.subnet_2_name
  master_authorized_networks  = var.master_authorized_networks
  http_load_balancing         = var.http_load_balancing
  ip_range_pods               = data.tfe_outputs.cloud.values.fleet_pod_subnet
  ip_range_services           = data.tfe_outputs.cloud.values.fleet_svc_subnet
  enable_private_endpoint     = false
  enable_private_nodes        = true
  release_channel = var.release_channel
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  identity_namespace          = var.identity_namespace
  initial_node_count          = var.initial_node_count
  remove_default_node_pool    = true
  enable_shielded_nodes       = true
  datapath_provider           = "ADVANCED_DATAPATH"
  enable_binary_authorization = var.enable_binary_authorization
  config_connector            = var.config_connector

  node_pools = [
    {
      name                        = "gke-default-node-pool"
      machine_type                = "e2-standard-2"
      node_location               = var.region
      min_count                   = 1
      max_count                   = 1
      auto_upgrade                = true
      enable_secure_boot          = true
      enable_integrity_monitoring = true
      spot                        = true
    },
  ]
}

resource "google_gke_hub_membership" "membership" {
  project       = data.tfe_outputs.cloud.values.fleet_project_id
  membership_id = module.kubernetes_engine.name
  endpoint {
    gke_cluster {
      resource_link = module.kubernetes_engine.cluster_id
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.kubernetes_engine.cluster_id}"
  }
}

resource "google_gke_hub_feature_membership" "feature_member" {
  project    = data.tfe_outputs.cloud.values.fleet_project_id
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.13.1"
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo                 = var.sync_repo
        sync_branch               = var.sync_branch
        policy_dir                = var.policy_dir
        secret_type               = "gcpserviceaccount"
        gcp_service_account_email = var.gcp_service_account_email
      }
    }
    policy_controller {
      enabled                    = true
      template_library_installed = true
      referential_rules_enabled  = true
    }
  }

  provider = google-beta
}
