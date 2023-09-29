data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_endpoint}"
  token                  = var.token
  cluster_ca_certificate = base64decode(data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_ca)
}

module "acm" {
  # https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/acm
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/acm"

  project_id                = data.tfe_outputs.svc-project-gcp.values.svc_proj_id
  cluster_name              = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_name
  location                  = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_location
  enable_policy_controller  = false
  sync_repo                 = "git@github.com:jeunii/crux-poc.git"
  sync_branch               = "build"
  policy_dir                = "asm_code_base/gcp/"
  secret_type               = "ssh"
  source_format             = "unstructured"
  create_ssh_key            = true

  create_metrics_gcp_sa = false
}
