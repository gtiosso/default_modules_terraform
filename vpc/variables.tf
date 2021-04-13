## GLOBAL VARIABLES ##
variable "context" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "team" {
  type = "string"
}

variable "app_source" {
  type = "string"
}

variable "provisioning_tool" {
  type = "string"
}

variable "provisioning_version" {
  type = "string"
}

variable "provisioning_source" {
  type = "string"
}

variable "deployment_tool" {
  type = "string"
}

variable "deployment_build_name" {
  type = "string"
}

## VPC VARIABLES ##
variable "vpc_options" {
  type    = "list"
  default = []
}

## ROUTE TABLE PUBLIC VARIABLES ##
variable "rt_public_options" {
  type    = "list"
  default = []
}

## DHCP OPTIONS VARIABLES ##
variable "dhcp_create" {
  type = bool
}

variable "dhcp_options" {
  type    = "list"
  default = []
}

## PEERING VARIABLES ##
variable "peer_create" {
  type = bool
}

variable "peer_options" {
  type    = "list"
  default = []
}

## VPN CONNECTION SITE-2-SITE VARIABLES ##
variable "vpn_create" {
  type = bool
}

variable "vpn_options" {
  type    = "list"
  default = []
}

## SECURITY GROUP VARIABLES ##
variable "sg_create" {
  type = bool
}

variable "sg_options" {
  type    = "list"
  default = []
}
