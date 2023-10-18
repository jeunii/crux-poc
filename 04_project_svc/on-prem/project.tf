module "svc_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 14.3"

  name                = "svc-on-prem"
  random_project_id   = true
  org_id              = var.org_id
  billing_account     = var.billing_id
  shared_vpc          = data.tfe_outputs.net-project-on-prem.values.net_proj_id
  activate_apis       = var.svc_project_apis
  folder_id           = data.tfe_outputs.folders.values.env_folder_ids["on-prem"]
  shared_vpc_subnets  = data.tfe_outputs.network-on-prem.values.on_prem_subnets_id
}
