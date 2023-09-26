variable "org_id" {
  type = string
}

variable "billing_id" {
  type = string
  default = "0146B8-6D3ADA-639083"
}

variable "net_project_apis" {
  type    = list(string)
  default = ["dns.googleapis.com", "servicenetworking.googleapis.com", "container.googleapis.com"]
}

variable "region" {
  type    = string
  default = "us-east4"
}

variable "svc_project_apis" {
  type    = list(string)
  default = ["serviceusage.googleapis.com", "krmapihosting.googleapis.com", "dns.googleapis.com", "compute.googleapis.com", "cloudfunctions.googleapis.com", "secretmanager.googleapis.com", "sourcerepo.googleapis.com", "cloudbuild.googleapis.com", "servicenetworking.googleapis.com", "container.googleapis.com", "gkeconnect.googleapis.com", "cloudresourcemanager.googleapis.com", "iam.googleapis.com", "multiclusterservicediscovery.googleapis.com", "trafficdirector.googleapis.com", "multiclusteringress.googleapis.com", "gkehub.googleapis.com", "anthosconfigmanagement.googleapis.com"]
}
