data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${var.on_prem_endpoint}"
  token                  = var.token
  cluster_ca_certificate = base64decode(var.on_prem_cluster_ca)
}

module "acm" {
  # https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/acm
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/acm"

  project_id                = data.tfe_outputs.svc-project-gcp.values.svc_proj_id
  cluster_name              = "on-prem-k8s-cluster"
  location                  = "global"
  enable_fleet_feature      = false
  enable_policy_controller  = false
  sync_repo                 = "git@github.com:jeunii/crux-poc.git"
  sync_branch               = "build"
  policy_dir                = "asm_code_base/on-prem/"
  secret_type               = "ssh"
  source_format             = "unstructured"
  create_ssh_key            = true

  create_metrics_gcp_sa = false
}
