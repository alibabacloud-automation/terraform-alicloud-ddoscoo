# Complete Example for Anti-DDoS Pro (DdosCoo) Module

This example demonstrates how to use the Anti-DDoS Pro (DdosCoo) module to create and manage Anti-DDoS Pro resources.

## Features

This example showcases the following features:

- Creating an Anti-DDoS Pro instance

The example also supports optional configurations (commented out by default):
- Configuring domain resources for web application protection (requires ICP-filed domain)
- Setting up port forwarding rules for non-HTTP traffic (requires real backend servers)
- Creating scheduler rules for traffic management (requires real IP addresses)

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.123.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.123.0 |

## Resources Created

By default, this example creates:

- Anti-DDoS Pro instance with basic protection capabilities

Optional resources (requires additional configuration):
- Domain resource configuration (requires ICP-filed domain)
- Port forwarding rules (requires real backend servers)
- Scheduler rules (requires real IP addresses)

## Variables

You can customize this example by modifying the variables in `terraform.tfvars` file:

```hcl
# Basic instance configuration
instance_name = "my-ddoscoo-instance"
base_bandwidth = "30"
bandwidth = "30"
service_bandwidth = "100"

# Domain configuration
domain_resources_config = {
  my_domain = {
    domain       = "mydomain.com"
    rs_type      = 0
    real_servers = ["1.2.3.4", "5.6.7.8"]
    proxy_types = [{
      proxy_ports = [80, 443]
      proxy_type  = "http"
    }]
  }
}

# Port forwarding configuration
ports_config = {
  my_port = {
    frontend_port     = "8080"
    backend_port      = "80"
    frontend_protocol = "tcp"
    real_servers      = ["1.2.3.4", "5.6.7.8"]
  }
}

# Tags
tags = {
  Environment = "production"
  Project     = "my-project"
}
```

## Outputs

This example outputs the following information:

- `ddoscoo_instance_id` - The ID of the created Anti-DDoS Pro instance
- `ddoscoo_instance_ip` - The IP address of the Anti-DDoS Pro instance
- `domain_resources_ids` - The IDs of the configured domain resources
- `ports_ids` - The IDs of the port forwarding rules
- `scheduler_rules_ids` - The IDs of the scheduler rules

## Important Notes

1. **Region**: This example is configured for `cn-hangzhou` region by default. Make sure to adjust the region according to your needs.

2. **Cost**: Anti-DDoS Pro instances incur charges. Please review the pricing before deploying.

3. **Default Configuration**: By default, this example only creates an Anti-DDoS Pro instance. Domain resources, port forwarding, and scheduler rules are set to empty maps to allow the example to run without requiring ICP-filed domains or real backend servers.

4. **Enabling Optional Resources**: To test domain resources, port forwarding, or scheduler rules:
   - Ensure you have an ICP-filed domain for domain resources
   - Provide real backend server IP addresses
   - Update the respective variables in `terraform.tfvars` or directly in `variables.tf`

5. **Domain Configuration**: Make sure your domain DNS is properly configured to point to the Anti-DDoS Pro instance IP.

6. **SSL Certificates**: If you're using HTTPS, you'll need to configure SSL certificates in the domain resource configuration.