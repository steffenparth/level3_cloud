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

variable "vm_count" {
  description = "Number of instances/vm's"
  # default = 3
}

variable "external_network" {
  description = "ID of the external network"
  type = string

}

# variable "external_network" {
  # description = "ID of the external network"
  # type        = string
# }
