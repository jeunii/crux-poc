# Define the variables for the Kubernetes cluster
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  default     = "on-prem-k8s"
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  default     = 1
}

variable "machine_type" {
  description = "Machine type for nodes"
  default     = "n2-standard-4"
}

variable "disk_size_gb" {
  description = "Disk size (in GB) for nodes"
  default     = 50
}

variable "region" {
  type    = string
  default = "us-east4"
}

variable "zone" {
  type    = string
  default = "us-east4-a"
}


