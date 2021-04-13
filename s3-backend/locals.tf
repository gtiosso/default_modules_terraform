locals {
  default_tags = {
    Context             = "${var.context}"
    Environment         = "${var.environment}"
    Team                = "${var.team}"
    AppSource           = "${var.app_source}"
    ProvisioningTool    = "${var.provisioning_tool}"
    ProvisioningVersion = "${var.provisioning_version}"
    ProvisioningSource  = "${var.provisioning_source}"
    DeploymentTool      = "${var.deployment_tool}"
    DeploymentBuildName = "${var.deployment_build_name}"
  }

  s3_count = var.s3_create == true ? length("${var.s3_options}") : 0
}
