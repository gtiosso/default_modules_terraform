# terraform {
#   backend "s3" {
#     encrypt = true
#     bucket  = "<target-aws-account-name>_terraform"
#     key     = "<my-project>/cloudwatch.tfstate"
#     region  = "us-east-1"
#   }
# }

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile                 = "${var.profile}"
}

module "cloudwatch" {
  source = "git::ssh://git@github.com/gtiosso/default_modules_terraform.git//cloudwatch"

  ## GLOBAL OPTIONS ##
  context               = "infra"
  environment           = "lab"
  team                  = "infra"
  app_source            = "https://github.com/teste/teste.git"
  provisioning_tool     = "terraform"
  provisioning_version  = "0.12.6"
  provisioning_source   = "https://github.com/teste/teste_terraform.git"
  deployment_tool       = "jenkins"
  deployment_build_name = "teste_provisioning"

  cloudwatch_dashboard_create = true
  cloudwatch_dashboard_options = list(
    {
      dashboard_name      = "cloudwatch-dashboard-infra-teste",
      dashboard_json_file = "documents/dashboard-body.json",
    },
  )

  cloudwatch_event_permission_create = true
  cloudwatch_event_permission_options = list(
    {
      principal        = "123456789012",
      statement_id     = "DevAccountAccess",
      action           = "events:PutEvents",
      create_condition = true,
      condition = list(
        {
          key   = "aws:PrincipalOrgID",
          type  = "StringEquals",
          value = "${var.aws_organizations_organization_id}",
        },
      )
    },
  )

  cloudwatch_event_rule_create = true
  cloudwatch_event_rule_options = list(
    {
      name                = "capture-aws-sign-in",
      description         = "Capture each AWS Console Sign In",
      event_pattern       = file("documents/event_pattern.json"),
      schedule_expression = "",
      role_arn            = "${var.aws_iam_role_for_cloudwatch_event_rule_arn}",
      is_enabled          = true,
      extraTags = {
      }
    },
  )

  cloudwatch_event_target_create = true
  cloudwatch_event_target_options = list(
    {
      rule_name                  = "capture-aws-sign-in",
      target_id                  = "Yada",
      arn                        = "${var.aws_kinesis_stream_for_event_target_arn}",
      input                      = file("documents/event_taget_input.json"),
      role_arn                   = "${var.aws_iam_role_for_event_target_arn}",
      create_run_command_targets = false,
      run_command_targets = list(
        {
          key    = "tag:Name",
          values = ["FooBar"],
        },
        {
          key    = "tag:Terminate",
          values = ["midnight"],
        },
      )
      create_ecs_target = false,
      ecs_target = list(
        {
          group               = "",
          launch_type         = "FARGATE",
          platform_version    = "",
          task_count          = 2,
          task_definition_arn = "${var.aws_ecs_task_definition_arn}",
          subnet_names = list(
            "subnet-48218124"
          )
          security_group_names = list(
            "tg-allow-event"
          )
        },
      )
      create_batch_target = false,
      batch_target = list(
        {
          job_definition = "",
          job_name       = "job_teste",
          array_size     = 10,
          job_attempts   = 5,
        },
      )
      create_kinesis_target = false,
      kinesis_target = list(
        {
          partition_key_path = "",
        },
      )
      create_sqs_target = false,
      sqs_target = list(
        {
          message_group_id = "",
        },
      )
      create_input_transformer = false,
      input_transformer = list(
        {
          input_paths    = "",
          input_template = "",
        },
      )
    },
  )

  cloudwatch_log_destination_create = true
  cloudwatch_log_destination_options = list(
    {
      name       = "test_destination",
      role_arn   = "${var.aws_iam_role_for_cloudwatch_log_destination_arn}",
      target_arn = "${var.aws_kinesis_stream_for_cloudwatch_log_destination_arn}",
    },
  )

  cloudwatch_log_destination_policy_create = true
  cloudwatch_log_destination_policy_options = list(
    {
      destination_name = "test_destination",
      access_policy    = "${var.aws_iam_policy_document_for_cloudwatch_log_destination_json}",
    },
  )

  cloudwatch_log_group_create = true
  cloudwatch_log_group_options = list(
    {
      name              = "teste-group",
      retention_in_days = 14,
      extraTags = {
      }
    },
  )

  cloudwatch_log_metric_filter_create = true
  cloudwatch_log_metric_filter_options = list(
    {
      name           = "MyAppAccessCount",
      pattern        = "",
      log_group_name = "teste-group",
      metric_transformation = list(
        {
          name          = "EventCount",
          namespace     = "YourNamespace",
          value         = "1",
          default_value = "1",
        },
      )
    },
  )

  cloudwatch_log_stream_create = true
  cloudwatch_log_stream_options = list(
    {
      name           = "SampleLogStream1234",
      log_group_name = "teste-group",
    },
  )

  cloudwatch_log_resource_policy_create = true
  cloudwatch_log_resource_policy_options = list(
    {
      policy_document = "${var.aws_iam_policy_document_for_elasticsearch_log_publishing_json}",
      policy_name     = "elasticsearch-log-publishing-policy",
    },
  )

  cloudwatch_log_subscription_filter_create = true
  cloudwatch_log_subscription_filter_options = list(
    {
      name            = "test_lambdafunction_logfilter",
      role_arn        = "${var.aws_iam_role_for_lambda_log_subscription_filter_arn}",
      log_group_name  = "teste-group",
      filter_pattern  = "logtype test",
      destination_arn = "${var.aws_kinesis_stream_for_log_subscription_filter_arn}",
      distribution    = "Random",
    },
  )

  cloudwatch_metric_alarm_create = true
  cloudwatch_metric_alarm_options = list(
    {
      alarm_name                = "terraform-test-foobar5",
      comparison_operator       = "GreaterThanOrEqualToThreshold",
      evaluation_periods        = "2",
      metric_name               = "CPUUtilization",
      namespace                 = "AWS/EC2",
      period                    = "120",
      statistic                 = "Average",
      threshold                 = "80",
      alarm_description         = "This metric monitors ec2 cpu utilization",
      insufficient_data_actions = [],
    },
  )
}
