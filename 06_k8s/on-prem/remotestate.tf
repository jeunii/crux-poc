data "tfe_outputs" "network-on-prem" {
  organization = "crux-ocm"
  workspace    = "03_network-on-prem"
}

data "tfe_outputs" "svc-project-on-prem" {
  organization = "crux-ocm"
  workspace    = "04_svc_project-on-prem"
}
