# terraform {
#   required_providers {
#     openstack = {
#       source  = "terraform-provider-openstack/openstack"
#       version = "~> 3.3.0"
#     }
#   }
# }

# provider "openstack" {
#   auth_url    = "http://94.237.83.198/identity/v3"
#   user_name   = "admin"
#   password    = "secret"
#   tenant_name = "Development"
#   region      = "RegionOne"
#   domain_name = "default"
#   insecure    = true
# }

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.3.0"
    }
  }
}

provider "openstack" {
  auth_url    = var.auth_url
  user_name   = var.user_name
  password    = var.password
  tenant_name = var.tenant_name
  region      = var.region
  domain_name = var.domain_name
  insecure    = true
}
# terraform {
#   required_providers {
#     openstack = {
#       source  = "terraform-provider-openstack/openstack"
#       version = "~> 2.0.0"
#     }
#   }
# }

# provider "openstack" {
#   auth_url    = var.auth_url
#   user_name   = var.user_name
#   password    = var.password
#   tenant_name = var.tenant_name
#   region      = var.region
#   domain_name = var.domain_name
#   insecure    = true
# }
