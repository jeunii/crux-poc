module "acm" {
  # https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/acm
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/acm"

  project_id                = data.tfe_outputs.svc-project-gcp.values.svc_proj_id
  cluster_name              = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_name
  location                  = data.tfe_outputs.svc-k8s-gcp.values.svc_cluster_location
  enable_policy_controller  = false
  sync_repo                 = "git@github.com:GoogleCloudPlatform/anthos-config-management-samples.git"
  sync_branch               = "1.0.0"
  policy_dir                = "foo-corp"

  create_metrics_gcp_sa = false
}
