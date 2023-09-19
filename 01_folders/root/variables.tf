variable "org_id" {
  type = string
}

variable "folder_names" {
  type    = list(string)
  default = ["crux-poc"]
}


variable "region" {
  type    = string
  default = "us-east4"
}
