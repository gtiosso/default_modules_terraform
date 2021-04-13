## EC2 KEY PAIR OUTPUT ##
output "keypair_private_key_pem" {
  value       = "${tls_private_key.this[*].private_key_pem}"
  description = "The private key pair pem"
}

output "keypair_name" {
  value       = "${aws_key_pair.this[*].key_name}"
  description = "The key pair name"
}

output "keypair_fingerprint" {
  value       = "${aws_key_pair.this[*].fingerprint}"
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716"
}

## EC2 INSTANCE OUTPUT ##
output "instance_id" {
  value       = "${aws_instance.this[*].id}"
  description = "The instance ID"
}

output "instance_arn" {
  value       = "${aws_instance.this[*].arn}"
  description = "The ARN of instance"
}

output "instance_availability_zone" {
  value       = "${aws_instance.this[*].availability_zone}"
  description = "The availability zone of the instance"
}

output "instance_key_name" {
  value       = "${aws_instance.this[*].key_name}"
  description = "The key name of the instance"
}

output "instance_public_dns" {
  value       = "${aws_instance.this[*].public_dns}"
  description = "The public DNS name assigned to the instance"
}

output "instance_public_ip" {
  value       = "${aws_instance.this[*].public_ip}"
  description = "The public IP address assigned to the instance"
}

output "instance_private_dns" {
  value       = "${aws_instance.this[*].private_dns}"
  description = "The private DNS name assigned to the instance"
}

output "instance_private_ip" {
  value       = "${aws_instance.this[*].private_ip}"
  description = "The private IP address assigned to the instance"
}

output "instance_security_groups" {
  value       = "${aws_instance.this[*].security_groups}"
  description = "The associated security groups"
}

output "instance_subnet_id" {
  value       = "${aws_instance.this[*].subnet_id}"
  description = "The VPC subnet ID"
}

output "instance_state" {
  value       = "${aws_instance.this[*].instance_state}"
  description = "The state of the instance"
}

output "instance_name_public_ip" {
  value       = formatlist("Hostname: %s - Public IP: %s - Private IP: %s", aws_instance.this[*].tags.Name, aws_instance.this[*].public_ip, aws_instance.this[*].private_ip)
  description = "The public IP address assigned to the instance"
}

output "launch_configuration_id" {
  value       = "${aws_launch_configuration.this[*].id}"
  description = "The Launch Configuration ID"
}

output "launch_configuration_arn" {
  value       = "${aws_launch_configuration.this[*].arn}"
  description = "The Launch Configuration Name"
}

output "launch_configuration_name" {
  value       = "${aws_launch_configuration.this[*].name}"
  description = "The Launch Configuration Name"
}
