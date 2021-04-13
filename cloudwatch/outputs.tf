output "cloudwatch_dashboard_name" {
  value       = "${aws_cloudwatch_dashboard.this[*].name}"
  description = "The name of the dashboard."
}

output "cloudwatch_dashboard_arn" {
  value       = "${aws_cloudwatch_dashboard.this[*].arn}"
  description = "The Amazon Resource Name (ARN) of the dashboard."
}

output "cloudwatch_event_permission_id" {
  value       = "${aws_cloudwatch_event_permission.this[*].id}"
  description = "The statement ID of the CloudWatch Events permission."
}

output "cloudwatch_event_permission_principal" {
  value       = "${aws_cloudwatch_event_permission.this[*].principal}"
  description = "The 12-digit AWS account ID that you are permitting to put events to your default event bus."
}

output "cloudwatch_event_permission_statement_id" {
  value       = "${aws_cloudwatch_event_permission.this[*].statement_id}"
  description = "The identifier string for the external account that you are granting permissions to."
}

output "cloudwatch_event_permission_action" {
  value       = "${aws_cloudwatch_event_permission.this[*].action}"
  description = "The action that you are enabling the other account to perform."
}

output "cloudwatch_event_rule_id" {
  value       = "${aws_cloudwatch_event_rule.this[*].id}"
  description = "The name of the rule."
}

output "cloudwatch_event_rule_arn" {
  value       = "${aws_cloudwatch_event_rule.this[*].arn}"
  description = "The Amazon Resource Name (ARN) of the rule."
}

output "cloudwatch_event_rule_name" {
  value       = "${aws_cloudwatch_event_rule.this[*].name}"
  description = "The rule's name."
}

output "cloudwatch_log_destination_name" {
  value       = "${aws_cloudwatch_log_destination.this[*].name}"
  description = "The name for the log destination."
}

output "cloudwatch_log_destination_arn" {
  value       = "${aws_cloudwatch_log_destination.this[*].arn}"
  description = "The Amazon Resource Name (ARN) specifying the log destination."
}

output "cloudwatch_log_group_name" {
  value       = "${aws_cloudwatch_log_group.this[*].name}"
  description = "The name of the log group."
}

output "cloudwatch_log_group_arn" {
  value       = "${aws_cloudwatch_log_group.this[*].arn}"
  description = "The Amazon Resource Name (ARN) specifying the log group."
}

output "cloudwatch_log_group_retention_in_days" {
  value       = "${aws_cloudwatch_log_group.this[*].retention_in_days}"
  description = "The number of days to retain log events in the specified log group."
}

output "cloudwatch_log_metric_filter_name" {
  value       = "${aws_cloudwatch_log_metric_filter.this[*].name}"
  description = "The name of the metric filter."
}

output "cloudwatch_log_resource_policy_id" {
  value       = "${aws_cloudwatch_log_resource_policy.this[*].id}"
  description = "The name of the CloudWatch log resource policy."
}

output "cloudwatch_log_stream_name" {
  value       = "${aws_cloudwatch_log_stream.this[*].name}"
  description = "The name of the log stream."
}

output "cloudwatch_log_stream_arn" {
  value       = "${aws_cloudwatch_log_stream.this[*].arn}"
  description = "The Amazon Resource Name (ARN) specifying the log stream."
}

output "cloudwatch_log_subscription_filter_name" {
  value       = "${aws_cloudwatch_log_subscription_filter.this[*].name}"
  description = "The name for the subscription filter."
}

output "cloudwatch_metric_alarm_id" {
  value       = "${aws_cloudwatch_metric_alarm.this[*].id}"
  description = "The ID of the health check."
}

output "cloudwatch_metric_alarm_arn" {
  value       = "${aws_cloudwatch_metric_alarm.this[*].arn}"
  description = "The ARN of the cloudwatch metric alarm."
}

output "cloudwatch_metric_alarm_name" {
  value       = "${aws_cloudwatch_metric_alarm.this[*].alarm_name}"
  description = "The descriptive name for the alarm."
}
