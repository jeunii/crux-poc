output "host_project_id" {
  value = module.host_project.project_id
}

output "svc_project_id" {
  value = module.svc_project.project_id
}

output "fleet_project_id" {
  value = module.fleet_project.project_id
}
output "host_project_number" {
  value = module.host_project.project_number
}

output "svc_project_number" {
  value = module.svc_project.project_number
}

output "fleet_project_number" {
  value = module.fleet_project.project_number
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

// output "nat_ip" {
//   value = google_compute_address.nat_ip.address
// }

output "svc_pod_subnet" {
  value = "subnet-01-secondary-pods"
}

output "svc_svc_subnet" {
  value = "subnet-01-secondary-svc-01"
}

output "postresql_ip_range" {
  value = google_compute_global_address.peering_postresql.name
}

output "redis_ip_range" {
  value = google_compute_global_address.peering_redis.name
}
output "subnet_2" {
  value = module.vpc.subnets["${var.region}/subnet-02"].region
}

output "subnet_2_name" {
  value = module.vpc.subnets["${var.region}/subnet-02"].name
}

// output "nat_ip" {
//   value = google_compute_address.nat_ip.address
// }

output "fleet_pod_subnet" {
  value = "subnet-02-secondary-pods"
}

output "fleet_svc_subnet" {
  value = "subnet-02-secondary-svc-01"
}
