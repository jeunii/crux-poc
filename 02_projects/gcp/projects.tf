module "net_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "14.3.0"

  name                           = "net-gcp"
  random_project_id              = true
  org_id                         = var.org_id
  billing_account                = var.billing_id
  enable_shared_vpc_host_project = true
  activate_apis                  = var.net_project_apis
  folder_id                      = data.tfe_outputs.folders.values.env_folder_ids["gcp"]
}

module "svc_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 14.3"

  name                = "svc-gcp"
  random_project_id   = true
  org_id              = var.org_id
  billing_account     = var.billing_id
  shared_vpc          = module.net_project.project_id
  activate_apis       = var.svc_project_apis
  folder_id           = data.tfe_outputs.folders.values.env_folder_ids["gcp"]
  shared_vpc_subnets = [
    format("projects/%s/regions/%s/subnetworks/%s", module.net_project.project_id, var.region, "subnet-01")
  ]
  depends_on = [
    module.net_project
  ]
}
