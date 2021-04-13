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

variable "cloudwatch_dashboard_create" {
  type = bool
}

variable "cloudwatch_dashboard_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_event_permission_create" {
  type = bool
}

variable "cloudwatch_event_permission_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_event_rule_create" {
  type = bool
}

variable "cloudwatch_event_rule_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_event_target_create" {
  type = bool
}

variable "cloudwatch_event_target_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_destination_create" {
  type = bool
}

variable "cloudwatch_log_destination_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_destination_policy_create" {
  type = bool
}

variable "cloudwatch_log_destination_policy_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_group_create" {
  type = bool
}

variable "cloudwatch_log_group_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_metric_filter_create" {
  type = bool
}

variable "cloudwatch_log_metric_filter_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_stream_create" {
  type = bool
}

variable "cloudwatch_log_stream_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_resource_policy_create" {
  type = bool
}

variable "cloudwatch_log_resource_policy_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_log_subscription_filter_create" {
  type = bool
}

variable "cloudwatch_log_subscription_filter_options" {
  type    = "list"
  default = []
}

variable "cloudwatch_metric_alarm_create" {
  type = bool
}

variable "cloudwatch_metric_alarm_options" {
  type    = "list"
  default = []
}
