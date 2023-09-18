variable "org_id" {
  type = string
}

variable "parent" {
  type    = string
  default = "crux-poc"
}

variable "billing_id" {
  type = string
}

variable "folder_names" {
  type    = list(string)
  default = ["onprem"]
}

variable "host_project" {
  type        = string
  default     = "host-project"
  description = "Host Project name"
}

variable "svc_project" {
  type        = string
  default     = "svc-project"
  description = "svc Prod"
}

variable "host_project_apis" {
  type    = list(string)
  default = ["dns.googleapis.com", "servicenetworking.googleapis.com", "container.googleapis.com"]
}

variable "svc_project_apis" {
  type    = list(string)
  default = ["dns.googleapis.com", "compute.googleapis.com", "cloudfunctions.googleapis.com", "secretmanager.googleapis.com", "sourcerepo.googleapis.com", "cloudbuild.googleapis.com", "servicenetworking.googleapis.com", "sqladmin.googleapis.com", "container.googleapis.com"]
}

variable "region" {
  type    = string
  default = "us-east4"
}

variable "gke_master_nodes_cidr" {
  default = "172.16.0.0/28"
  type    = string
}

variable "access_token" {
  type = string
}

variable "shared_secret" {
  type        = string
  description = "(optional) describe your variable"
  default     = "topSecret"
}

variable "peer_gateway" {
  type    = string
  default = "projects/host-project-409f/regions/us-east4/vpnGateways/us-east4-gtw"
}


variable "tunnel_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "tunnel"
}
