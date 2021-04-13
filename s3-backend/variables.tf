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

## S3 BACKEND VARIABLES ##
variable "s3_create" {
  type = bool
}

variable "s3_options" {
  type    = "list"
  default = []
}
