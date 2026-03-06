Alibaba Cloud Anti-DDoS Pro (DdosCoo) Terraform Module

# terraform-alicloud-ddoscoo

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ddoscoo/blob/main/README-CN.md)

Terraform module which creates Anti-DDoS Pro (DdosCoo) resources on Alibaba Cloud. This module helps protect your web applications and services from DDoS attacks by providing comprehensive DDoS protection capabilities including instance management, domain resource configuration, port forwarding rules, and intelligent traffic scheduling. For more information about Anti-DDoS Pro service, see [Alibaba Cloud Anti-DDoS Pro](https://www.alibabacloud.com/product/ddos).

## Usage

This module provides a complete Anti-DDoS Pro solution including instance creation, domain protection configuration, port forwarding setup, and traffic scheduling rules.

```terraform
module "ddoscoo" {
  source = "alibabacloud-automation/ddoscoo/alicloud"

  # Instance configuration
  create_instance = true
  instance_config = {
    name              = "my-ddoscoo-instance"
    base_bandwidth    = "30"
    bandwidth         = "30"
    service_bandwidth = "100"
    port_count        = "50"
    domain_count      = "50"
    product_type      = "ddoscoo"
    period            = "1"
  }

  # Domain resources configuration
  domain_resources_config = {
    web_domain = {
      domain       = "example.com"
      rs_type      = 0
      real_servers = ["192.168.1.1:80", "192.168.1.2:80"]
      https_ext    = "{\"EnableHttp2\":\"on\",\"EnableHttps\":\"on\"}"
      proxy_types = [{
        proxy_ports = [80, 443]
        proxy_type  = "http"
      }]
    }
  }

  # Port forwarding configuration
  ports_config = {
    tcp_port = {
      frontend_port     = 80
      backend_port      = 8080
      frontend_protocol = "TCP"
      real_servers      = ["192.168.1.1:8080", "192.168.1.2:8080"]
      config = {
        persistence_timeout = 1800
      }
    }
  }

  # Scheduler rules configuration
  scheduler_rules_config = {
    scheduler_rule_1 = {
      rule_name         = "my-scheduler-rule"
      rule_type         = 1
      resource_group_id = null
      param             = "param1"
      rules = [
        {
          type       = "A"
          value      = "192.168.1.1"
          priority   = 1
          value_type = 1
          region_id  = "cn-hangzhou"
          status     = "enabled"
        }
      ]
    }
  }

  # Tags
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ddoscoo/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.123.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.123.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ddoscoo_domain_resource.domain_resources](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_domain_resource) | resource |
| [alicloud_ddoscoo_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_instance) | resource |
| [alicloud_ddoscoo_port.ports](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_port) | resource |
| [alicloud_ddoscoo_scheduler_rule.scheduler_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_scheduler_rule) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | Whether to create a new Anti-DDoS Pro instance. If false, an existing instance ID must be provided. | `bool` | `true` | no |
| <a name="input_domain_resources_config"></a> [domain\_resources\_config](#input\_domain\_resources\_config) | Configuration for Anti-DDoS Pro domain resources. Each key represents a domain resource configuration. | <pre>map(object({<br>    domain          = string<br>    rs_type         = number<br>    instance_ids    = optional(list(string), null)<br>    real_servers    = list(string)<br>    https_ext       = optional(string, null)<br>    cert            = optional(string, null)<br>    cert_identifier = optional(string, null)<br>    cert_name       = optional(string, null)<br>    cert_region     = optional(string, "cn-hangzhou")<br>    custom_headers  = optional(map(string), null)<br>    key             = optional(string, null)<br>    ocsp_enabled    = optional(bool, null)<br>    proxy_types = list(object({<br>      proxy_ports = list(number)<br>      proxy_type  = optional(string, "http")<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | The configuration parameters for the Anti-DDoS Pro instance. The attributes 'name', 'base\_bandwidth', 'bandwidth', 'service\_bandwidth', 'port\_count', 'domain\_count', 'product\_type', and 'period' are required. | <pre>object({<br>    name              = string<br>    base_bandwidth    = optional(string, "30")<br>    bandwidth         = optional(string, "30")<br>    service_bandwidth = optional(string, "100")<br>    port_count        = optional(string, "50")<br>    domain_count      = optional(string, "50")<br>    product_type      = optional(string, "ddoscoo")<br>    period            = optional(string, "1")<br>    normal_bandwidth  = optional(string, null)<br>    normal_qps        = optional(string, null)<br>    edition_sale      = optional(string, "coop")<br>    product_plan      = optional(string, null)<br>    address_type      = optional(string, "Ipv4")<br>    bandwidth_mode    = optional(string, null)<br>    function_version  = optional(string, null)<br>    modify_type       = optional(string, null)<br>  })</pre> | <pre>{<br>  "name": null<br>}</pre> | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | The ID of an existing Anti-DDoS Pro instance. Required when create\_instance is false. | `string` | `null` | no |
| <a name="input_ports_config"></a> [ports\_config](#input\_ports\_config) | Configuration for Anti-DDoS Pro port forwarding rules. Each key represents a port configuration. | <pre>map(object({<br>    instance_id       = optional(string, null)<br>    frontend_port     = string<br>    backend_port      = optional(string, null)<br>    frontend_protocol = string<br>    real_servers      = list(string)<br>    config = optional(object({<br>      persistence_timeout = optional(number, null)<br>    }), null)<br>  }))</pre> | `{}` | no |
| <a name="input_scheduler_rules_config"></a> [scheduler\_rules\_config](#input\_scheduler\_rules\_config) | Configuration for Anti-DDoS Pro scheduler rules. Each key represents a scheduler rule configuration. | <pre>map(object({<br>    rule_name         = string<br>    param             = optional(string, null)<br>    resource_group_id = optional(string, null)<br>    rule_type         = number<br>    rules = list(object({<br>      type       = optional(string, "A")<br>      value      = optional(string, null)<br>      priority   = optional(number, null)<br>      value_type = optional(number, null)<br>      region_id  = optional(string, null)<br>      status     = optional(string, null)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_resource_ids"></a> [all\_resource\_ids](#output\_all\_resource\_ids) | All resource IDs created by this module |
| <a name="output_ddoscoo_instance_create_time"></a> [ddoscoo\_instance\_create\_time](#output\_ddoscoo\_instance\_create\_time) | The creation time of the Anti-DDoS Pro instance |
| <a name="output_ddoscoo_instance_id"></a> [ddoscoo\_instance\_id](#output\_ddoscoo\_instance\_id) | The ID of the Anti-DDoS Pro instance |
| <a name="output_ddoscoo_instance_ip"></a> [ddoscoo\_instance\_ip](#output\_ddoscoo\_instance\_ip) | The IP address of the Anti-DDoS Pro instance |
| <a name="output_ddoscoo_instance_status"></a> [ddoscoo\_instance\_status](#output\_ddoscoo\_instance\_status) | The status of the Anti-DDoS Pro instance |
| <a name="output_domain_resources_cnames"></a> [domain\_resources\_cnames](#output\_domain\_resources\_cnames) | The CNAME addresses of the Anti-DDoS Pro domain resources |
| <a name="output_domain_resources_ids"></a> [domain\_resources\_ids](#output\_domain\_resources\_ids) | The IDs of the Anti-DDoS Pro domain resources |
| <a name="output_ports_ids"></a> [ports\_ids](#output\_ports\_ids) | The IDs of the Anti-DDoS Pro port forwarding rules |
| <a name="output_scheduler_rules_cnames"></a> [scheduler\_rules\_cnames](#output\_scheduler\_rules\_cnames) | The CNAME addresses of the Anti-DDoS Pro scheduler rules |
| <a name="output_scheduler_rules_ids"></a> [scheduler\_rules\_ids](#output\_scheduler\_rules\_ids) | The IDs of the Anti-DDoS Pro scheduler rules |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)