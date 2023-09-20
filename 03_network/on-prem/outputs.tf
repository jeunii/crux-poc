output "gke_subnets_id" {
  value = module.vpc.subnets_ids
  sensitive = false
}

output "gke_subnets" {
  value = module.vpc.subnets
  sensitive = true
}
