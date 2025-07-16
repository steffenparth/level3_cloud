# variable "auth_url" {}
# variable "tenant_name" {}
# variable "user_name" {}
# variable "password" {}
# variable "region" {}
# variable "domain_name" {}
# variable "image_name" {}
# variable "flavor_name" {}
# variable "keypair_name" {}
# variable "external_network" {
#   description = "The ID of the external network for the router."
#   type = string
#   default = "2563758b-4a31-4d41-a591-701568108c2e"
# }
variable "auth_url" {
  description = "OpenStack auth URL"
  type        = string
}

variable "tenant_name" {
  description = "OpenStack tenant name"
  type        = string
}

variable "user_name" {
  description = "OpenStack username"
  type        = string
}

variable "password" {
  description = "OpenStack password"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "OpenStack region"
  type        = string
}

variable "domain_name" {
  description = "OpenStack domain name"
  type        = string
}

variable "image_name" {
  description = "Name of the image to use for the instance"
  type        = string
}

variable "flavor_name" {
  description = "Name of the flavor to use for the instance"
  type        = string
}

variable "keypair_name" {
  description = "Name of the keypair to use for the instance"
  type        = string
}

variable "external_network" {
  description = "ID of the external network"
  type        = string
}
