阿里云 Anti-DDoS Pro (DdosCoo) Terraform 模块

# terraform-alicloud-ddoscoo

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ddoscoo/blob/main/README.md) | 简体中文

用于在阿里云上创建 Anti-DDoS Pro (DdosCoo) 资源的 Terraform 模块。该模块通过提供全面的 DDoS 防护能力来帮助保护您的 Web 应用程序和服务免受 DDoS 攻击，包括实例管理、域名资源配置、端口转发规则和智能流量调度。有关 Anti-DDoS Pro 服务的更多信息，请参阅 [阿里云 Anti-DDoS Pro](https://www.alibabacloud.com/product/ddos)。

## 使用方法

该模块提供完整的 Anti-DDoS Pro 解决方案，包括实例创建、域名保护配置、端口转发设置和流量调度规则。

```terraform
module "ddoscoo" {
  source = "alibabacloud-automation/ddoscoo/alicloud"
  
  # 实例配置
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

  # 域名资源配置
  domain_resources_config = {
    web_domain = {
      domain       = "example.com"
      rs_type      = 0
      real_servers = ["192.168.1.1", "192.168.1.2"]
      proxy_types = [{
        proxy_ports = [80, 443]
        proxy_type  = "http"
      }]
    }
  }

  # 端口转发配置
  ports_config = {
    tcp_port = {
      frontend_port     = "8080"
      backend_port      = "80"
      frontend_protocol = "tcp"
      real_servers      = ["192.168.1.1", "192.168.1.2"]
    }
  }

  # 标签
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ddoscoo/tree/main/examples/complete)

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

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)