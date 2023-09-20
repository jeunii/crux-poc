module "hub" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/fleet-membership"

  project_id       = data.tfe_outputs.svc-project-gcp.values.svc_proj_id
  cluster_name     = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_name
  location         = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_location
}
