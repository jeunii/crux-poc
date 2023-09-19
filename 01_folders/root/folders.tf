module "root_folder" {
  source  = "terraform-google-modules/folders/google"
  version = "4.0.0"
  parent  = "organizations/${var.org_id}"
  names   = var.folder_names
}
