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

  subnet_count = var.environment == "prod" ? 2 : 1
  peer_count   = var.peer_create == true ? length(var.peer_options) : 0
  vpn_count    = var.vpn_create == true ? length(var.vpn_options) : 0
  sg_count     = var.sg_create == true ? length(var.sg_options) : 0
  dhcp_count   = var.dhcp_create == true ? length(var.dhcp_options) : 0
}
