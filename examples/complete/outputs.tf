output "ddoscoo_instance_id" {
  description = "The ID of the Anti-DDoS Pro instance"
  value       = module.ddoscoo.ddoscoo_instance_id
}

output "ddoscoo_instance_ip" {
  description = "The IP address of the Anti-DDoS Pro instance"
  value       = module.ddoscoo.ddoscoo_instance_ip
}

output "domain_resources_ids" {
  description = "The IDs of the Anti-DDoS Pro domain resources"
  value       = module.ddoscoo.domain_resources_ids
}

output "domain_resources_cnames" {
  description = "The CNAME addresses of the Anti-DDoS Pro domain resources"
  value       = module.ddoscoo.domain_resources_cnames
}

output "ports_ids" {
  description = "The IDs of the Anti-DDoS Pro port forwarding rules"
  value       = module.ddoscoo.ports_ids
}

output "scheduler_rules_ids" {
  description = "The IDs of the Anti-DDoS Pro scheduler rules"
  value       = module.ddoscoo.scheduler_rules_ids
}

output "all_resource_ids" {
  description = "All resource IDs created by this module"
  value       = module.ddoscoo.all_resource_ids
}