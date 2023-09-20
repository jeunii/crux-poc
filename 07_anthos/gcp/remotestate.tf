data "tfe_outputs" "folders" {
  organization = "crux-ocm"
  workspace    = "01_folders"
}

data "tfe_outputs" "net-project-gcp" {
  organization = "crux-ocm"
  workspace    = "02_net_project-gcp"
}

data "tfe_outputs" "svc-project-gcp" {
  organization = "crux-ocm"
  workspace    = "04_svc_project-gcp"
}

data "tfe_outputs" "network-gcp" {
  organization = "crux-ocm"
  workspace    = "03_network-gcp"
}

data "tfe_outputs" "svc-k8s-gcp" {
  organization = "crux-ocm"
  workspace    = "06_k8s-gcp"
}
