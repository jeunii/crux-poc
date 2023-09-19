module "root_folder" {
  source  = "terraform-google-modules/folders/google"
  version = "4.0.0"
  parent  = "organizations/${var.org_id}"
  names   = var.root_folder_name
}

module "env_folders" {
  source  = "terraform-google-modules/folders/google"
  version = "4.0.0"
  parent  = module.root_folder.id
  names   = var.env_folder_names
}
