module "net_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "14.3.0"

  name                           = "net-on-prem"
  random_project_id              = true
  org_id                         = var.org_id
  billing_account                = var.billing_id
  enable_shared_vpc_host_project = true
  activate_apis                  = var.net_project_apis
  folder_id                      = data.tfe_outputs.folders.values.env_folder_ids["on-prem"]
}
