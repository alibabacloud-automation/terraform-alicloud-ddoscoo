variable "create_instance" {
  description = "Whether to create a new Anti-DDoS Pro instance. If false, an existing instance ID must be provided."
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "The ID of an existing Anti-DDoS Pro instance. Required when create_instance is false."
  type        = string
  default     = null
}

variable "instance_config" {
  description = "The configuration parameters for the Anti-DDoS Pro instance. The attributes 'name', 'base_bandwidth', 'bandwidth', 'service_bandwidth', 'port_count', 'domain_count', 'product_type', and 'period' are required."
  type = object({
    name              = string
    base_bandwidth    = optional(string, "30")
    bandwidth         = optional(string, "30")
    service_bandwidth = optional(string, "100")
    port_count        = optional(string, "50")
    domain_count      = optional(string, "50")
    product_type      = optional(string, "ddoscoo")
    period            = optional(string, "1")
    normal_bandwidth  = optional(string, null)
    normal_qps        = optional(string, null)
    edition_sale      = optional(string, "coop")
    product_plan      = optional(string, null)
    address_type      = optional(string, "Ipv4")
    bandwidth_mode    = optional(string, null)
    function_version  = optional(string, null)
    modify_type       = optional(string, null)
  })
  default = {
    name = null
  }
}

variable "domain_resources_config" {
  description = "Configuration for Anti-DDoS Pro domain resources. Each key represents a domain resource configuration."
  type = map(object({
    domain          = string
    rs_type         = number
    instance_ids    = optional(list(string), null)
    real_servers    = list(string)
    https_ext       = optional(string, null)
    cert            = optional(string, null)
    cert_identifier = optional(string, null)
    cert_name       = optional(string, null)
    cert_region     = optional(string, "cn-hangzhou")
    key             = optional(string, null)
    ocsp_enabled    = optional(bool, null)
    proxy_types = list(object({
      proxy_ports = list(number)
      proxy_type  = optional(string, "http")
    }))
  }))
  default = {}
}

variable "ports_config" {
  description = "Configuration for Anti-DDoS Pro port forwarding rules. Each key represents a port configuration."
  type = map(object({
    instance_id       = optional(string, null)
    frontend_port     = string
    backend_port      = optional(string, null)
    frontend_protocol = string
    real_servers      = list(string)
    config = optional(object({
      persistence_timeout = optional(number, null)
    }), null)
  }))
  default = {}
}

variable "scheduler_rules_config" {
  description = "Configuration for Anti-DDoS Pro scheduler rules. Each key represents a scheduler rule configuration."
  type = map(object({
    rule_name         = string
    param             = optional(string, null)
    resource_group_id = optional(string, null)
    rule_type         = number
    rules = list(object({
      type       = optional(string, "A")
      value      = optional(string, null)
      priority   = optional(number, null)
      value_type = optional(number, null)
      region_id  = optional(string, null)
      status     = optional(string, null)
    }))
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}