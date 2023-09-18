output "host_project_id" {
  value = module.host_project.project_id
}

output "svc_project_id" {
  value = module.svc_project.project_id
}

output "host_project_number" {
  value = module.host_project.project_number
}

output "svc_project_number" {
  value = module.svc_project.project_number
}

output "vpc_id" {
  value = module.vpc.network_id
}

output "vpc_name" {
  value = module.vpc.network_name
}

output "subnet_1" {
  value = module.vpc.subnets["${var.region}/subnet-01"].region
}

output "subnet_1_name" {
  value = module.vpc.subnets["${var.region}/subnet-01"].name
}
