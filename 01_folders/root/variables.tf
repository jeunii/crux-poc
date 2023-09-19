variable "org_id" {
  type = string
}

variable "folder_names" {
  type    = list(string)
  default = ["crux-poc"]
}

variable "access_token" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east4"
}
