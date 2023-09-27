module "kubernetes-engine" {
  # https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "27.0.0"
  
  name                      = "svc-demo"
  regional                  = true
  region                    = var.region
  zones                     = var.zones
  network                   = data.tfe_outputs.network-gcp.values.shared_vpc_name
  network_project_id        = data.tfe_outputs.net-project-gcp.values.net_proj_id
  project_id                = data.tfe_outputs.svc-project-gcp.values.svc_proj_id
  subnetwork                = "node"
  ip_range_pods             = "pod"
  ip_range_services         = "service"
  create_service_account    = true
  gce_pd_csi_driver         = true
  release_channel           = "STABLE"
  kubernetes_version        = "1.27.3-gke.100"
  cluster_resource_labels   = { "mesh_id" : "proj-${data.tfe_outputs.svc-project-gcp.values.svc_proj_number}" }

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "n2-standard-4"
      node_locations            = "us-east4-a,us-east4-b"
      min_count                 = 1
      max_count                 = 6
      spot                      = true
    }
  ]
}
