# terraform {
#   backend "s3" {
#     encrypt = true
#     bucket  = "<target-aws-account-name>_terraform"
#     key     = "<my-project>/vpc.tfstate"
#     region  = "us-east-1"
#   }
# }

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile                 = "${var.profile}"
}

module "vpc" {
  source = "git::ssh://git@github.com/gtiosso/default_modules_terraform.git//vpc"


  ## GLOBAL OPTIONS ##
  context               = "infra"
  environment           = "lab"
  team                  = "infra"
  app_source            = "https://github.com/teste/teste.git"
  provisioning_tool     = "terraform"
  provisioning_version  = "0.12.6"
  provisioning_source   = "https://github.com/teste/teste.git"
  deployment_tool       = "jenkins"
  deployment_build_name = "teste_provisioning"

  ## VPC OPTIONS ##
  vpc_options = list(
    {
      cidr_block           = "10.200.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      extraTags = {
      }
    }
  )

  ## DHCP OPTIONS ##
  dhcp_create = false
  dhcp_options = list(
    {
      domain_name = ""
      domain_name_servers = list(
        "10.100.0.2",
        "10.254.0.11",
      )
      ntp_servers          = []
      netbios_name_servers = []
      netbios_node_type    = ""
      extraTags = {
      }
    }
  )

  ## PEERING OPTIONS ##
  peer_create = true
  peer_options = list(
    {
      peer_account_id               = "${element(data.terraform_remote_state.vpc.outputs.vpc_owner_id, 1)}"
      peer_vpc_id                   = "${element(data.terraform_remote_state.vpc.outputs.vpc_id, 1)}"
      peer_region                   = "us-east-1"
      auto_accept                   = false
      peer_destination_context_name = "bridge"
      peer_destination_cidr_block   = "${element(data.terraform_remote_state.vpc.outputs.vpc_cidr, 1)}"
      extraTags = {
      }
    },
  )

  ## VPN CONNECTION SITE-2-SITE OPTIONS ##
  vpn_create = false
  vpn_options = list(
    {
      vpn_destination_context_name = "juari",
      vpn_type                     = "ipsec.1",
      cgw_type                     = "ipsec.1",
      cgw_bgp_asn                  = 65000,
      cgw_ip_address               = "222.48.187.81",
      extraTags = {
      }
    },
  )

  ## ROUTE TABLE PUBLIC OPTIONS ##
  rt_public_options = list(
    {
      destination_cidr_block = list(
        "0.0.0.0/0",
      )
      extraTags = {
      }
    }
  )

  ## SECURITY GROUP OPTIONS ##
  sg_create = true
  sg_options = list(
    {
      name = "sg_teste_allow",
      desc = "Security Group Allow",
      sg_ingress = list(
        {
          from_port = "0",
          to_port   = "0",
          protocol  = "-1",
          cidr_blocks = list(
            "188.90.226.30/32",
            "10.0.0.0/8",
          )
        },
      )
      sg_egress = list(
        {
          from_port = "0"
          to_port   = "0"
          protocol  = "-1"
          cidr_blocks = list(
            "0.0.0.0/0",
          )
        },
      )
      extraTags = {
      }
    },
  )
}
