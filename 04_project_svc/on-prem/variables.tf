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
  default = ["serviceusage.googleapis.com", "dns.googleapis.com", "compute.googleapis.com", "container.googleapis.com", "cloudresourcemanager.googleapis.com", "iam.googleapis.com"]
}
