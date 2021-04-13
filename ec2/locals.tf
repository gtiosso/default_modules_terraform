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

  key_pair_count             = var.key_pair_create == true ? length("${var.key_pair_options}") : 0
  instance_count             = var.instance_create == true ? length("${var.instance_options}") : 0
  launch_configuration_count = var.launch_configuration_create == true ? length("${var.launch_configuration_options}") : 0
}
