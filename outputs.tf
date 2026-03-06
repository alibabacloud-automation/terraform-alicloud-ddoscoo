# Anti-DDoS Pro Instance outputs
output "ddoscoo_instance_id" {
  description = "The ID of the Anti-DDoS Pro instance"
  value       = var.create_instance ? alicloud_ddoscoo_instance.instance[0].id : var.instance_id
}

output "ddoscoo_instance_ip" {
  description = "The IP address of the Anti-DDoS Pro instance"
  value       = var.create_instance ? alicloud_ddoscoo_instance.instance[0].ip : null
}

output "ddoscoo_instance_status" {
  description = "The status of the Anti-DDoS Pro instance"
  value       = var.create_instance ? alicloud_ddoscoo_instance.instance[0].status : null
}

output "ddoscoo_instance_create_time" {
  description = "The creation time of the Anti-DDoS Pro instance"
  value       = var.create_instance ? alicloud_ddoscoo_instance.instance[0].create_time : null
}

# Domain Resource outputs
output "domain_resources_ids" {
  description = "The IDs of the Anti-DDoS Pro domain resources"
  value       = { for k, v in alicloud_ddoscoo_domain_resource.domain_resources : k => v.id }
}

output "domain_resources_cnames" {
  description = "The CNAME addresses of the Anti-DDoS Pro domain resources"
  value       = { for k, v in alicloud_ddoscoo_domain_resource.domain_resources : k => v.cname }
}

# Port Forwarding outputs
output "ports_ids" {
  description = "The IDs of the Anti-DDoS Pro port forwarding rules"
  value       = { for k, v in alicloud_ddoscoo_port.ports : k => v.id }
}

# Scheduler Rule outputs
output "scheduler_rules_ids" {
  description = "The IDs of the Anti-DDoS Pro scheduler rules"
  value       = { for k, v in alicloud_ddoscoo_scheduler_rule.scheduler_rules : k => v.id }
}

output "scheduler_rules_cnames" {
  description = "The CNAME addresses of the Anti-DDoS Pro scheduler rules"
  value       = { for k, v in alicloud_ddoscoo_scheduler_rule.scheduler_rules : k => v.cname }
}

# Summary outputs
output "all_resource_ids" {
  description = "All resource IDs created by this module"
  value = {
    instance_id         = var.create_instance ? alicloud_ddoscoo_instance.instance[0].id : var.instance_id
    domain_resource_ids = { for k, v in alicloud_ddoscoo_domain_resource.domain_resources : k => v.id }
    port_ids            = { for k, v in alicloud_ddoscoo_port.ports : k => v.id }
    scheduler_rule_ids  = { for k, v in alicloud_ddoscoo_scheduler_rule.scheduler_rules : k => v.id }
  }
}