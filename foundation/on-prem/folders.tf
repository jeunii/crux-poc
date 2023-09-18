module "main_folder" {
  source  = "terraform-google-modules/folders/google"
  version = "3.1.0"
  parent  = data.tfe_outputs.folders.values.onprem_folder_id
  names   = var.folder_names
}
