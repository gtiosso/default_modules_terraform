variable "region" {
  type        = "string"
  description = "AWS Default Region"
  default     = "us-east-1"
}

variable "credentials_file" {
  type        = "string"
  description = "AWS Credetials PATH"
  default     = "~/.aws/credentials"
}

variable "profile" {
  type        = "string"
  description = "AWS Credetials Profile"
}

