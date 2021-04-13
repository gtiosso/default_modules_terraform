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

## EC2 KEY PAIR VARIABLES ##
variable "key_pair_create" {
  type = bool
}

variable "key_pair_options" {
  type    = "list"
  default = []
}

## EC2 INSTANCE VARIABLES ##
variable "instance_create" {
  type = bool
}

variable "instance_options" {
  type    = "list"
  default = []
}

## EC2 LAUNCH CONFIGURATION VARIABLES ##
variable "launch_configuration_create" {
  type = bool
}

variable "launch_configuration_options" {
  type    = "list"
  default = []
}
