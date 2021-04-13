data "aws_vpc" "this" {
  tags = {
    Name = format("vpc-%s", var.context)
  }
}

data "aws_subnet" "this" {
  count  = "${local.instance_count}"
  vpc_id = "${data.aws_vpc.this.id}"
  filter {
    name   = "tag:Name"
    values = list(lookup(element(var.instance_options, count.index), "subnet_name"))
  }
}

data "aws_security_groups" "instance" {
  count = "${local.instance_count}"
  filter {
    name   = "tag:Name"
    values = lookup(element(var.instance_options, count.index), "security_group_names")
  }
}

