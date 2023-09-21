output "on_prem_subnets_id" {
  value = module.vpc.subnets_ids
  sensitive = false
}

output "on_prem_subnets" {
  value = module.vpc.subnets
  sensitive = true
}

output "k8s_master_internal_ip" {
  value = google_compute_address.k8s-master-internal-ip
  sensitive = true
}

output "k8s_master_external_ip" {
  value = google_compute_address.k8s-master-external-ip
  sensitive = true
}