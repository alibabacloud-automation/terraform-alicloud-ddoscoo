# Define local values for resource IDs and configurations
locals {
  # Instance ID reference - use created instance or external instance ID
  this_ddoscoo_instance_id = var.create_instance ? alicloud_ddoscoo_instance.instance[0].id : var.instance_id
}

# Anti-DDoS Pro Instance
resource "alicloud_ddoscoo_instance" "instance" {
  count = var.create_instance ? 1 : 0

  name              = var.instance_config.name
  base_bandwidth    = var.instance_config.base_bandwidth
  bandwidth         = var.instance_config.bandwidth
  service_bandwidth = var.instance_config.service_bandwidth
  port_count        = var.instance_config.port_count
  domain_count      = var.instance_config.domain_count
  product_type      = var.instance_config.product_type
  period            = var.instance_config.period
  normal_bandwidth  = var.instance_config.normal_bandwidth
  normal_qps        = var.instance_config.normal_qps
  edition_sale      = var.instance_config.edition_sale
  product_plan      = var.instance_config.product_plan
  address_type      = var.instance_config.address_type
  bandwidth_mode    = var.instance_config.bandwidth_mode
  function_version  = var.instance_config.function_version
  modify_type       = var.instance_config.modify_type
  tags              = var.tags
}

# Domain Resources
resource "alicloud_ddoscoo_domain_resource" "domain_resources" {
  for_each = var.domain_resources_config

  domain          = each.value.domain
  rs_type         = each.value.rs_type
  instance_ids    = each.value.instance_ids != null ? each.value.instance_ids : [local.this_ddoscoo_instance_id]
  real_servers    = each.value.real_servers
  https_ext       = each.value.https_ext
  cert            = each.value.cert
  cert_identifier = each.value.cert_identifier
  cert_name       = each.value.cert_name
  cert_region     = each.value.cert_region
  key             = each.value.key
  ocsp_enabled    = each.value.ocsp_enabled

  dynamic "proxy_types" {
    for_each = each.value.proxy_types
    content {
      proxy_ports = proxy_types.value.proxy_ports
      proxy_type  = proxy_types.value.proxy_type
    }
  }
}

# Port Forwarding Rules
resource "alicloud_ddoscoo_port" "ports" {
  for_each = var.ports_config

  instance_id       = each.value.instance_id != null ? each.value.instance_id : local.this_ddoscoo_instance_id
  frontend_port     = each.value.frontend_port
  backend_port      = each.value.backend_port
  frontend_protocol = each.value.frontend_protocol
  real_servers      = each.value.real_servers

  dynamic "config" {
    for_each = each.value.config != null ? [each.value.config] : []
    content {
      persistence_timeout = config.value.persistence_timeout
    }
  }
}

# Scheduler Rules
resource "alicloud_ddoscoo_scheduler_rule" "scheduler_rules" {
  for_each = var.scheduler_rules_config

  rule_name         = each.value.rule_name
  param             = each.value.param
  resource_group_id = each.value.resource_group_id
  rule_type         = each.value.rule_type

  dynamic "rules" {
    for_each = each.value.rules
    content {
      type       = rules.value.type
      value      = rules.value.value
      priority   = rules.value.priority
      value_type = rules.value.value_type
      region_id  = rules.value.region_id
      status     = rules.value.status
    }
  }
}