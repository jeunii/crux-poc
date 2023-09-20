output "svc_cluster_endpoint" {
  value     = module.kubernetes-engine.endpoint
  sensitive = true
}

output "svc_cluster_id" {
  value = module.kubernetes-engine.cluster_id
}

output "svc_cluster_location" {
  value = module.kubernetes-engine.location
}

output "svc_cluster_name" {
  value = module.kubernetes-engine.name
}
