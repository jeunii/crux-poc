data "tfe_outputs" "folders" {
  organization = "crux-ocm"
  workspace    = "01_folders"
}

data "tfe_outputs" "net-project-on-prem" {
  organization = "crux-ocm"
  workspace    = "02_net_project-on-prem"
}

data "tfe_outputs" "network-on-prem" {
  organization = "crux-ocm"
  workspace    = "03_network-on-prem"
}
