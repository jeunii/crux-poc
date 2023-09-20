variable "region" {
  type    = string
  default = "us-east4"
}

variable "zones" {
  type    = list(string)
  default = ["us-east4-a", "us-east4-b"]
}
