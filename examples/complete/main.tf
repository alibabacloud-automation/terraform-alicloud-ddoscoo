# Configure the Alicloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Example usage of the ddoscoo module
module "ddoscoo" {
  source = "../../"

  # Instance configuration
  create_instance = true
  instance_config = {
    name              = "ddoscoo-example-instance"
    base_bandwidth    = "30"
    bandwidth         = "30"
    service_bandwidth = "100"
    port_count        = "50"
    domain_count      = "50"
    product_type      = "ddoscoo"
    period            = "1"
  }

  # Tags
  tags = {
    CreatedBy   = "Terraform"
    Environment = "Development"
    Project     = "DDoS-COO-Example"
  }
}