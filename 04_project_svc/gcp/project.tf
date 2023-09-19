module "svc_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 14.3"

  name                = "svc-gcp"
  random_project_id   = true
  org_id              = var.org_id
  billing_account     = var.billing_id
  shared_vpc          = data.tfe_outputs.projects-gcp.values.net_proj_id
  activate_apis       = var.svc_project_apis
  folder_id           = data.tfe_outputs.folders.values.env_folder_ids["gcp"]
  shared_vpc_subnets  = data.tfe_outputs.network-gcp.values.gke_subnets_id
}
