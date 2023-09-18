module "gkehub_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.fleet_project.project_id, module.svc_project.project_id]

  bindings = {
    "roles/gkehub.serviceAgent" = [
      local.fleet_project_gkehub_sa,
    ]
  }
  depends_on = [
    google_project_service_identity.gkehub_sa,
  ]
}

locals {
  svc_project_gke_sa          = "serviceAccount:service-${module.svc_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  fleet_project_gke_sa        = "serviceAccount:service-${module.fleet_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  svc_project_googleapis_sa   = "serviceAccount:${module.svc_project.project_number}@cloudservices.gserviceaccount.com"
  fleet_project_googleapis_sa = "serviceAccount:${module.fleet_project.project_number}@cloudservices.gserviceaccount.com"
  fleet_project_gkehub_sa     = "serviceAccount:service-${module.fleet_project.project_number}@gcp-sa-gkehub.iam.gserviceaccount.com"
}

resource "google_project_service_identity" "gkehub_sa" {
  provider = google-beta

  project = module.fleet_project.project_id
  service = "gkehub.googleapis.com"
}

module "region1_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.svc_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.svc_project_gke_sa,
      local.svc_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.svc_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.svc_project_gke_sa,
    ]
    "roles/gkehub.admin" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/container.admin" = [
      "serviceAccount:${google_service_account.cc_service_account.email}",
      "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]",
    ]
    "roles/owner" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/multiclusterservicediscovery.serviceAgent" = [
      "serviceAccount:service-${module.fleet_project.project_number}@gcp-sa-mcsd.iam.gserviceaccount.com"
    ]
    "roles/compute.networkViewer" = [
      "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]",
    ]
  }
}

module "region1_fleet_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.fleet_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.fleet_project_gke_sa,
      local.fleet_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.fleet_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.fleet_project_gke_sa,
    ]
    "roles/source.reader" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/gkehub.admin" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/container.admin" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/owner" = [
      "serviceAccount:${google_service_account.cc_service_account.email}"
    ]
    "roles/compute.networkViewer" = [
      "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]",
    ]
  }
}

resource "google_service_account" "cc_service_account" {
  project      = module.fleet_project.project_id
  account_id   = "configconnector"
  display_name = "Service Account used by config connector"
}

resource "google_service_account_iam_binding" "cc_service_account_binding" {
  service_account_id = google_service_account.cc_service_account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[config-management-system/root-reconciler]",
    "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[cnrm-system/cnrm-controller-manager-fleetmanagement]",
  ]
}

resource "google_service_account" "cs_service_account" {
  project      = module.svc_project.project_id
  account_id   = "config-sync-sa"
  display_name = "Service Account used by config sync"
}

module "gkehub_iam_bindings_networks" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.host_project.project_id]

  bindings = {
    "roles/compute.networkViewer" = [
      "serviceAccount:${module.fleet_project.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]",
    ]
    "roles/multiclusterservicediscovery.serviceAgent" = [
      "serviceAccount:service-${module.fleet_project.project_number}@gcp-sa-mcsd.iam.gserviceaccount.com"
    ]
  }
}
