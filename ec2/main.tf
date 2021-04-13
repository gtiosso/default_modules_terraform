resource "tls_private_key" "this" {
  count      = local.key_pair_count
  algorithm = "RSA"
  rsa_bits  = 4096
}

## EC2 KEY PAIR RESOURCE ##
resource "aws_key_pair" "this" {
  count      = local.key_pair_count
  key_name   = lookup(element(var.key_pair_options, count.index), "key_name", "")
  public_key = tls_private_key.this[count.index].public_key_openssh
}

## EC2 INSTANCE RESOURCE ##
resource "aws_instance" "this" {
  count                       = "${local.instance_count}"
  ami                         = lookup(element(var.instance_options, count.index), "ami")
  availability_zone           = lookup(element(var.instance_options, count.index), "availability_zone", "")
  placement_group             = lookup(element(var.instance_options, count.index), "placement_group ", "")
  host_id                     = lookup(element(var.instance_options, count.index), "host_id", "")
  instance_type               = lookup(element(var.instance_options, count.index), "type")
  ebs_optimized               = lookup(element(var.instance_options, count.index), "ebs_optimized", false)
  vpc_security_group_ids      = "${data.aws_security_groups.instance[count.index].ids}"
  subnet_id                   = "${data.aws_subnet.this[count.index].id}"
  associate_public_ip_address = lookup(element(var.instance_options, count.index), "associate_public_ip_address", "")
  private_ip                  = lookup(element(var.instance_options, count.index), "private_ip", "")
  iam_instance_profile        = lookup(element(var.instance_options, count.index), "iam_instance_profile", "")
  source_dest_check           = lookup(element(var.instance_options, count.index), "source_dest_check", "")
  key_name                    = lookup(element(var.instance_options, count.index), "key_name", "")
  user_data                   = lookup(element(var.instance_options, count.index), "user_data", "")
  
  root_block_device {
    volume_size = lookup(element(var.instance_options, count.index), "root_volume_size")
    volume_type = lookup(element(var.instance_options, count.index), "root_volume_type")
  }

  dynamic "ebs_block_device" {
    for_each = lookup(element(var.instance_options, count.index), "create_ebs_block_device") == false ? [] : [for ebs_block_device in lookup(element(var.instance_options, count.index), "ebs_block_device") : {
      device_name = ebs_block_device.device_name
      volume_type = ebs_block_device.volume_type
      volume_size = ebs_block_device.volume_size
    }]

    content {
      device_name = ebs_block_device.value.device_name
      volume_type = ebs_block_device.value.volume_type
      volume_size = ebs_block_device.value.volume_size
    }
  }
  tags = merge(
    {
      Name = lookup(element(var.instance_options, count.index), "name"),
    },
    "${local.default_tags}",
    lookup(element(var.instance_options, count.index), "extraTags")
  )
}

resource "aws_launch_configuration" "this" {
  count                            = "${local.launch_configuration_count}"
  name                             = lookup(element(var.launch_configuration_options, count.index), "name", "")
  image_id                         = lookup(element(var.launch_configuration_options, count.index), "image_id")
  instance_type                    = lookup(element(var.launch_configuration_options, count.index), "instance_type")
  key_name                         = lookup(element(var.launch_configuration_options, count.index), "key_name", "")
  security_groups                  = lookup(element(var.launch_configuration_options, count.index), "security_groups", "")
  associate_public_ip_address      = lookup(element(var.launch_configuration_options, count.index), "associate_public_ip_address", "")
  vpc_classic_link_id              = lookup(element(var.launch_configuration_options, count.index), "vpc_classic_link_id", "")
  vpc_classic_link_security_groups = lookup(element(var.launch_configuration_options, count.index), "vpc_classic_link_security_groups", "")
  spot_price                       = lookup(element(var.launch_configuration_options, count.index), "spot_price", "")
  user_data                        = lookup(element(var.launch_configuration_options, count.index), "user_data", "")
  iam_instance_profile             = lookup(element(var.launch_configuration_options, count.index), "iam_instance_profile", "")

  root_block_device {
    volume_size = lookup(element(var.launch_configuration_options, count.index), "root_volume_size")
    volume_type = lookup(element(var.launch_configuration_options, count.index), "root_volume_type")
  }

  dynamic "ebs_block_device" {
    for_each = lookup(element(var.launch_configuration_options, count.index), "create_ebs_block_device") == false ? [] : [for ebs_block_device in lookup(element(var.launch_configuration_options, count.index), "ebs_block_device") : {
      device_name = ebs_block_device.device_name
      volume_type = ebs_block_device.volume_type
      volume_size = ebs_block_device.volume_size
    }]

    content {
      device_name = ebs_block_device.value.device_name
      volume_type = ebs_block_device.value.volume_type
      volume_size = ebs_block_device.value.volume_size
    }
  }
}
