variable "region" {
  type        = "string"
  description = "AWS Default Region"
  default     = "us-east-1"
}

variable "credentials_file" {
  type        = "string"
  description = "AWS Credetials PATH"
  default     = "~/.aws/credentials"
}

variable "profile" {
  type        = "string"
  description = "AWS Credetials Profile"
}

variable "aws_organizations_organization_id" {
  type        = "string"
  description = "Account id to limit the event bus permissions you are granting"
}

variable "aws_iam_role_for_cloudwatch_event_rule_arn" {
  type        = "string"
  description = "The role arn of the cloudwatch event rule"
}

variable "aws_kinesis_stream_for_event_target_arn" {
  type        = "string"
  description = "The Kinesis stream arn of the cloudwatch event target"
}

variable "aws_iam_role_for_event_target_arn" {
  type        = "string"
  description = "The role arn of the cloudwatch event target"
}

variable "aws_ecs_task_definition_arn" {
  type        = "string"
  description = "The ECS task definition arn"
}

variable "aws_iam_role_for_cloudwatch_log_destination_arn" {
  type        = "string"
  description = "The role arn of the cloudwatch log destination"
}

variable "aws_kinesis_stream_for_cloudwatch_log_destination_arn" {
  type        = "string"
  description = "The Kinesis stream arn for cloudwatch log destination"
}

variable "aws_iam_policy_document_for_cloudwatch_log_destination_json" {
  type        = "string"
  description = "The json policy for cloudwatch log destination"
}

variable "aws_iam_policy_document_for_elasticsearch_log_publishing_json" {
  type        = "string"
  description = "The json policy for elasticsearch log publishing"
}

variable "aws_iam_role_for_lambda_log_subscription_filter_arn" {
  type        = "string"
  description = "The role arn for cloudwatch log subscription filter"
}

variable "aws_kinesis_stream_for_log_subscription_filter_arn" {
  type        = "string"
  description = "The Kinesis stream arn for cloudwatch log subscription filter"
}
