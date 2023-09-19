variable "org_id" {
  type = string
}

variable "net_project_apis" {
  type    = list(string)
  default = ["dns.googleapis.com", "servicenetworking.googleapis.com", "container.googleapis.com"]
}