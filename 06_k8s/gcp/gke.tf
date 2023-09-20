module "kubernetes-engine" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "27.0.0"
  
  name                      = "svc-demo"
  regional                  = true
  region                    = var.region
  zones                     = var.zones
  network                   = data.tfe_outputs.network-gcp.values.shared_vpc_name
  network_project_id        = data.tfe_outputs.projects-gcp.values.net_proj_id
  project_id                = data.tfe_outputs.projects-gcp.values.svc_proj_id
  subnetwork                = "node"
  ip_range_pods             = "pod"
  ip_range_services         = "service"
  create_service_account    = true
  gce_pd_csi_driver         = true
  grant_registry_access     = true
  release_channel           = "STABLE"
  kubernetes_version        = "1.27.3-gke.100"
}
