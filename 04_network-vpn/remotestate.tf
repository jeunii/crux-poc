data "tfe_outputs" "net-project-gcp" {
  organization = "crux-ocm"
  workspace    = "02_net_project-gcp"
}

data "tfe_outputs" "network-gcp" {
  organization = "crux-ocm"
  workspace    = "03_network-gcp"
}

data "tfe_outputs" "net-project-on-prem" {
  organization = "crux-ocm"
  workspace    = "02_net_project-on-prem"
}

data "tfe_outputs" "network-on-prem" {
  organization = "crux-ocm"
  workspace    = "03_network-on-prem"
}
