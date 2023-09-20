output "on_prem_subnets_id" {
  value = module.vpc.subnets_ids
  sensitive = false
}

output "on_prem_subnets" {
  value = module.vpc.subnets
  sensitive = true
}
