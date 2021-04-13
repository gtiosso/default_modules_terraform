# terraform {
#   backend "s3" {
#     encrypt = true
#     bucket  = "<target-aws-account-name>_terraform"
#     key     = "<my-project>/ec2.tfstate"
#     region  = "us-east-1"
#   }
# }

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile                 = "${var.profile}"
}

module "ec2" {
  source = "git::ssh://git@github.com/gtiosso/default_modules_terraform.git//ec2"

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

  ## EC2 KEY PAIR OPTIONS ##
  key_pair_create = true
  key_pair_options = list(
    {
      key_name        = "aws-haproxy-teste",
    },
  )

  ## EC2 INSTANCE OPTIONS ##
  instance_create = true
  instance_options = list(
    {
      name                        = "haproxy-public",
      ami                         = "ami-0b898040803850657",
      type                        = "t2.nano",
      subnet_name                 = "subnet-public-infra-zone-a",
      associate_public_ip_address = true,
      private_ip                  = "",
      source_dest_check           = true,
      key_name                    = "aws-haproxy",
      user_data                   = null,
      root_volume_size            = "8",
      root_volume_type            = "standard",
      iam_instance_profile        = "",
      create_ebs_block_device     = false
      ebs_block_device = list(
        {
          device_name = ""
          volume_type = ""
          volume_size = ""
        },
      )
      security_group_names = list(
        "sg_teste_allow",
      )
      extraTags = {
      }
    },
  )

  ## EC2 INSTANCE LAUNCH CONFIGURATION OPTIONS ##
  launch_configuration_create = true
  launch_configuration_options = list(
    {
      name                        = "haproxy-public",
      image_id                    = "ami-0b898040803850657",
      instance_type               = "t2.nano",
      key_name                    = "aws-haproxy",
      associate_public_ip_address = true,
      spot_price                  = "0.0960",
      user_data                   = null,
      root_volume_size            = "8",
      root_volume_type            = "standard",
      vpc_classic_link_id         = null,
      iam_instance_profile        = "",
      create_ebs_block_device     = false,
      ebs_block_device = list(
        {
          device_name = ""
          volume_type = ""
          volume_size = ""
        },
      ),
      security_group = list(
        "sg_teste_allow",
      ),
      vpc_classic_link_security_groups = list(
        "sg_teste_allow",
      ),
    }
  )
}
