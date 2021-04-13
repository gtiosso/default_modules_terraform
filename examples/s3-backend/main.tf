# terraform {
#   backend "s3" {
#     encrypt = true
#     bucket  = "<target-aws-account-name>_terraform"
#     key     = "<my-project>/s3-backend.tfstate"
#     region  = "us-east-1"
#   }
# }

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile                 = "${var.profile}"
}

module "s3-backend" {
  source = "git::ssh://git@github.com/gtiosso/default_modules_terraform.git//s3-backend"

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

  ## S3 BACKEND OPTIONS ##
  s3_create = true
  s3_options = list(
    {
      name          = "infra-lab-terraform-state",
      acl           = "private",
      force_destroy = true,
      versioning    = false,
      sse_algorithm = "AES256",
      extraTags = {
      }
    },
  )
}
