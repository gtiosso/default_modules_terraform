resource "aws_cloudwatch_dashboard" "this" {
  count          = "${local.cloudwatch_dashboard_count}"
  dashboard_name = lookup(element(var.cloudwatch_dashboard_options, count.index), "dashboard_name")
  dashboard_body = file(lookup(element(var.cloudwatch_dashboard_options, count.index), "dashboard_json_file"))
}

resource "aws_cloudwatch_event_permission" "this" {
  count        = "${local.cloudwatch_event_permission_count}"
  principal    = lookup(element(var.cloudwatch_event_permission_options, count.index), "principal")
  statement_id = lookup(element(var.cloudwatch_event_permission_options, count.index), "statement_id")
  action       = lookup(element(var.cloudwatch_event_permission_options, count.index), "action")

  dynamic "condition" {
    for_each = lookup(element(var.cloudwatch_event_permission_options, count.index), "create_condition") == false ? [] : [for condition in lookup(element(var.cloudwatch_event_permission_options, count.index), "condition") : {
      key   = condition.key
      type  = condition.type
      value = condition.value
    }]

    content {
      key   = condition.value.key
      type  = condition.value.type
      value = condition.value.value
    }
  }
}

resource "aws_cloudwatch_event_rule" "this" {
  count               = "${local.cloudwatch_event_rule_count}"
  name                = lookup(element(var.cloudwatch_event_rule_options, count.index), "name")
  description         = lookup(element(var.cloudwatch_event_rule_options, count.index), "description")
  event_pattern       = lookup(element(var.cloudwatch_event_rule_options, count.index), "event_pattern")
  schedule_expression = lookup(element(var.cloudwatch_event_rule_options, count.index), "schedule_expression")
  role_arn            = lookup(element(var.cloudwatch_event_rule_options, count.index), "role_arn")
  is_enabled          = lookup(element(var.cloudwatch_event_rule_options, count.index), "is_enabled")
  tags = merge(
    {
      Name = lookup(element(var.cloudwatch_event_rule_options, count.index), "name")
    },
    "${local.default_tags}",
    lookup(element(var.cloudwatch_event_rule_options, count.index), "extraTags")
  )
}

resource "aws_cloudwatch_event_target" "this" {
  count     = "${local.cloudwatch_event_target_count}"
  rule      = lookup(element(var.cloudwatch_event_target_options, count.index), "rule_name")
  target_id = lookup(element(var.cloudwatch_event_target_options, count.index), "target_id")
  arn       = lookup(element(var.cloudwatch_event_target_options, count.index), "arn")
  input     = lookup(element(var.cloudwatch_event_target_options, count.index), "input")
  role_arn  = lookup(element(var.cloudwatch_event_target_options, count.index), "role_arn")

  dynamic "run_command_targets" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_run_command_targets") == false ? [] : [for run_command_targets in lookup(element(var.cloudwatch_event_target_options, count.index), "run_command_targets") : {
      key    = run_command_targets.key
      values = run_command_targets.values
    }]

    content {
      key    = run_command_targets.value.key
      values = run_command_targets.value.values
    }
  }

  dynamic "ecs_target" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_ecs_target") == false ? [] : [for ecs_target in lookup(element(var.cloudwatch_event_target_options, count.index), "ecs_target") : {
      group               = ecs_target.group
      launch_type         = ecs_target.launch_type
      platform_version    = ecs_target.platform_version
      task_count          = ecs_target.task_count
      task_definition_arn = ecs_target.task_definition_arn
    }]

    content {
      group               = ecs_target.value.group
      launch_type         = ecs_target.value.launch_type
      platform_version    = ecs_target.value.platform_version
      task_count          = ecs_target.value.task_count
      task_definition_arn = ecs_target.value.task_definition_arn

      network_configuration {
        subnets         = "${data.aws_subnet_ids.this[count.index].ids}"
        security_groups = "${data.aws_security_groups.this[count.index].ids}"
      }
    }
  }

  dynamic "batch_target" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_batch_target") == false ? [] : [for batch_target in lookup(element(var.cloudwatch_event_target_options, count.index), "batch_target") : {
      job_definition = batch_target.job_definition
      job_name       = batch_target.job_name
      array_size     = batch_target.array_size
      job_attempts   = batch_target.job_attempts
    }]

    content {
      job_definition = batch_target.value.job_definition
      job_name       = batch_target.value.job_name
      array_size     = batch_target.value.array_size
      job_attempts   = batch_target.value.job_attempts
    }
  }

  dynamic "kinesis_target" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_kinesis_target") == false ? [] : [for kinesis_target in lookup(element(var.cloudwatch_event_target_options, count.index), "kinesis_target") : {
      partition_key_path = kinesis_target.partition_key_path
    }]

    content {
      partition_key_path = kinesis_target.value.partition_key_path
    }
  }

  dynamic "sqs_target" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_sqs_target") == false ? [] : [for sqs_target in lookup(element(var.cloudwatch_event_target_options, count.index), "sqs_target") : {
      message_group_id = sqs_target.message_group_id
    }]

    content {
      message_group_id = sqs_target.value.message_group_id
    }
  }

  dynamic "input_transformer" {
    for_each = lookup(element(var.cloudwatch_event_target_options, count.index), "create_input_transformer") == false ? [] : [for input_transformer in lookup(element(var.cloudwatch_event_target_options, count.index), "input_transformer") : {
      input_paths    = input_transformer.input_paths
      input_template = input_transformer.input_template
    }]

    content {
      input_paths    = input_transformer.value.input_paths
      input_template = input_transformer.value.input_template
    }
  }
  depends_on = ["aws_cloudwatch_event_rule.this"]
}

resource "aws_cloudwatch_log_destination" "this" {
  count      = "${local.cloudwatch_log_destination_count}"
  name       = lookup(element(var.cloudwatch_log_destination_options, count.index), "name")
  role_arn   = lookup(element(var.cloudwatch_log_destination_options, count.index), "role_arn")
  target_arn = lookup(element(var.cloudwatch_log_destination_options, count.index), "target_arn")
}

resource "aws_cloudwatch_log_destination_policy" "this" {
  count            = "${local.cloudwatch_log_destination_policy_count}"
  destination_name = lookup(element(var.cloudwatch_log_destination_policy_options, count.index), "destination_name")
  access_policy    = lookup(element(var.cloudwatch_log_destination_policy_options, count.index), "access_policy")
}

resource "aws_cloudwatch_log_group" "this" {
  count             = "${local.cloudwatch_log_group_count}"
  name              = lookup(element(var.cloudwatch_log_group_options, count.index), "name")
  retention_in_days = lookup(element(var.cloudwatch_log_group_options, count.index), "retention_in_days") == "" ? 14 : lookup(element(var.cloudwatch_log_group_options, count.index), "retention_in_days")
  tags = merge(
    {
      Name = lookup(element(var.cloudwatch_log_group_options, count.index), "name")
    },
    "${local.default_tags}",
    lookup(element(var.cloudwatch_log_group_options, count.index), "extraTags")
  )
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  count          = "${local.cloudwatch_log_metric_filter_count}"
  name           = lookup(element(var.cloudwatch_log_metric_filter_options, count.index), "name")
  pattern        = lookup(element(var.cloudwatch_log_metric_filter_options, count.index), "pattern")
  log_group_name = lookup(element(var.cloudwatch_log_metric_filter_options, count.index), "log_group_name")

  dynamic "metric_transformation" {
    for_each = [for metric_transformation in lookup(element(var.cloudwatch_log_metric_filter_options, count.index), "metric_transformation") : {
      name          = metric_transformation.name
      namespace     = metric_transformation.namespace
      value         = metric_transformation.value
      default_value = metric_transformation.default_value
    }]

    content {
      name          = metric_transformation.value.name
      namespace     = metric_transformation.value.namespace
      value         = metric_transformation.value.value
      default_value = metric_transformation.value.default_value
    }
  }
  depends_on = ["aws_cloudwatch_log_group.this"]
}

resource "aws_cloudwatch_log_stream" "this" {
  count          = "${local.cloudwatch_log_stream_count}"
  name           = lookup(element(var.cloudwatch_log_stream_options, count.index), "name")
  log_group_name = lookup(element(var.cloudwatch_log_stream_options, count.index), "log_group_name")
  depends_on     = ["aws_cloudwatch_log_group.this"]
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  count           = "${local.cloudwatch_log_resource_policy_count}"
  policy_document = lookup(element(var.cloudwatch_log_resource_policy_options, count.index), "policy_document")
  policy_name     = lookup(element(var.cloudwatch_log_resource_policy_options, count.index), "policy_name")
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count           = "${local.cloudwatch_log_subscription_filter_count}"
  name            = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "name")
  role_arn        = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "role_arn")
  log_group_name  = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "log_group_name")
  filter_pattern  = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "filter_pattern")
  destination_arn = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "destination_arn")
  distribution    = lookup(element(var.cloudwatch_log_subscription_filter_options, count.index), "distribution")
  depends_on      = ["aws_cloudwatch_log_group.this"]
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count                     = "${local.cloudwatch_metric_alarm_count}"
  alarm_name                = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "alarm_name")
  comparison_operator       = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "comparison_operator")
  evaluation_periods        = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "evaluation_periods")
  metric_name               = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "metric_name")
  namespace                 = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "namespace")
  period                    = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "period")
  statistic                 = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "statistic")
  threshold                 = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "threshold")
  alarm_description         = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "alarm_description")
  insufficient_data_actions = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "insufficient_data_actions")
  treat_missing_data        = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "treat_missing_data", "missing")
  alarm_actions             = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "alarm_actions", [])
  dimensions                = lookup(element(var.cloudwatch_metric_alarm_options, count.index), "dimensions")
}
