data "tfe_outputs" "folders" {
  organization = "crux-ocm"
  workspace    = "01_folders"
}

data "tfe_outputs" "svc-project-on-prem" {
  organization = "crux-ocm"
  workspace    = "04_svc_project-on-prem"
}