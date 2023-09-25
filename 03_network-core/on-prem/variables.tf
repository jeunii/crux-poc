variable "org_id" {
  type = string
}

variable "billing_id" {
  type = string
  default = "0146B8-6D3ADA-639083"
}

variable "region" {
  type    = string
  default = "us-east4"
}

variable "onprem_node_ip_range" {
  type = string
  default = "192.168.0.0/22"
}