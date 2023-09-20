data "tfe_outputs" "folders" {
  organization = "crux-ocm"
  workspace    = "01_folders"
}

data "tfe_outputs" "projects-gcp" {
  organization = "crux-ocm"
  workspace    = "02_projects-gcp"
}

data "tfe_outputs" "network-gcp" {
  organization = "crux-ocm"
  workspace    = "03_network-gcp"
}
