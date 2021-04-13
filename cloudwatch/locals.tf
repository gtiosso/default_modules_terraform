locals {
  default_tags = {
    Context             = "${var.context}"
    Environment         = "${var.environment}"
    Team                = "${var.team}"
    AppSource           = "${var.app_source}"
    ProvisioningTool    = "${var.provisioning_tool}"
    ProvisioningVersion = "${var.provisioning_version}"
    ProvisioningSource  = "${var.provisioning_source}"
    DeploymentTool      = "${var.deployment_tool}"
    DeploymentBuildName = "${var.deployment_build_name}"
  }

  cloudwatch_dashboard_count               = var.cloudwatch_dashboard_create == true ? length(var.cloudwatch_dashboard_options) : 0
  cloudwatch_event_permission_count        = var.cloudwatch_event_permission_create == true ? length(var.cloudwatch_event_permission_options) : 0
  cloudwatch_event_rule_count              = var.cloudwatch_event_rule_create == true ? length(var.cloudwatch_event_rule_options) : 0
  cloudwatch_event_target_count            = var.cloudwatch_event_target_create == true ? length(var.cloudwatch_event_target_options) : 0
  cloudwatch_log_destination_count         = var.cloudwatch_log_destination_create == true ? length(var.cloudwatch_log_destination_options) : 0
  cloudwatch_log_destination_policy_count  = var.cloudwatch_log_destination_policy_create == true ? length(var.cloudwatch_log_destination_policy_options) : 0
  cloudwatch_log_group_count               = var.cloudwatch_log_group_create == true ? length(var.cloudwatch_log_group_options) : 0
  cloudwatch_log_metric_filter_count       = var.cloudwatch_log_metric_filter_create == true ? length(var.cloudwatch_log_metric_filter_options) : 0
  cloudwatch_log_stream_count              = var.cloudwatch_log_stream_create == true ? length(var.cloudwatch_log_stream_options) : 0
  cloudwatch_log_resource_policy_count     = var.cloudwatch_log_resource_policy_create == true ? length(var.cloudwatch_log_resource_policy_options) : 0
  cloudwatch_log_subscription_filter_count = var.cloudwatch_log_subscription_filter_create == true ? length(var.cloudwatch_log_subscription_filter_options) : 0
  cloudwatch_metric_alarm_count            = var.cloudwatch_metric_alarm_create == true ? length(var.cloudwatch_metric_alarm_options) : 0
}
