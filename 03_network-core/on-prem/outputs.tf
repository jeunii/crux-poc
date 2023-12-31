output "on_prem_subnets_id" {
  value = module.vpc.subnets_ids
  sensitive = false
}

output "on_prem_subnets" {
  value = module.vpc.subnets
  sensitive = true
}

output "k8s_master_external_ip" {
  value = google_compute_address.k8s-master-external-ip.address
  sensitive = true
}

output "shared_vpc_name" {
  value = module.vpc.network_name
}
