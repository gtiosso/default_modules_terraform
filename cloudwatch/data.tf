data "aws_vpc" "this" {
  tags = {
    Name = format("vpc-%s", var.context)
  }
}

data "aws_subnet_ids" "this" {
  count  = "${local.cloudwatch_event_target_count}"
  vpc_id = "${data.aws_vpc.this.id}"
  filter {
    name   = "tag:Name"
    values = lookup(element(lookup(element(var.cloudwatch_event_target_options, count.index), "ecs_target"), count.index), "subnet_names")
  }
}
data "aws_security_groups" "this" {
  count = "${local.cloudwatch_event_target_count}"
  filter {
    name   = "tag:Name"
    values = lookup(element(lookup(element(var.cloudwatch_event_target_options, count.index), "ecs_target"), count.index), "security_group_names")
  }
}
