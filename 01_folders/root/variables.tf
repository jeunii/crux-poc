variable "org_id" {
  type = string
}

variable "root_folder_name" {
  type    = list(string)
  default = ["crux-poc"]
}

variable "env_folder_names" {
  type    = list(string)
  default = ["gcp", "on-prem"]
}

variable "region" {
  type    = string
  default = "us-east4"
}
