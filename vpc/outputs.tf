## VPC OUTPUT ##
output "vpc_arn" {
  value       = "${aws_vpc.this.arn}"
  description = "Amazon Resource Name (ARN) of VPC"
}

output "vpc_id" {
  value       = "${aws_vpc.this.id}"
  description = "The ID of the VPC"
}

output "vpc_owner_id" {
  value       = "${aws_vpc.this.owner_id}"
  description = "The ID of the AWS account that owns the VPC"
}

output "vpc_cidr" {
  value       = "${aws_vpc.this.cidr_block}"
  description = "The CIDR block of the VPC"
}

output "vpc_dns_support" {
  value       = "${aws_vpc.this.enable_dns_support}"
  description = "The DNS Support of the VPC"
}

output "vpc_dns_hostnames" {
  value       = "${aws_vpc.this.enable_dns_hostnames}"
  description = "The DNS Hostnames of the VPC"
}

## SUBNET PRIVATE OUTPUT ##
output "subnet_private_id" {
  value       = "${aws_subnet.private[*].id}"
  description = "The ID of the subnet"
}

output "subnet_private_arn" {
  value       = "${aws_subnet.private[*].arn}"
  description = "The ARN of the subnet"
}

output "subnet_private_name" {
  value       = "${aws_subnet.private[*].tags.Name}"
  description = "The Name of Subnet"
}

## SUBNET PUBLIC OUTPUT ##
output "subnet_public_id" {
  value       = "${aws_subnet.public[*].id}"
  description = "The ID of the subnet"
}

output "subnet_public_arn" {
  value       = "${aws_subnet.public[*].arn}"
  description = "The ARN of the subnet"
}

output "subnet_public_name" {
  value       = "${aws_subnet.public[*].tags.Name}"
  description = "The Name of Subnet"
}


## INTERNET GATEWAY OUTPUT ##
output "igw_id" {
  value       = "${aws_internet_gateway.this.id}"
  description = "The ID of the Internet Gateway"
}

## DHCP OPTIONS OUTPUT ##
output "dhcp_options_id" {
  value       = "${aws_vpc_dhcp_options.this[*].id}"
  description = "The ID of the DHCP Options Set"
}

## PEERING OUTPUT ##
output "peering_id" {
  value       = "${aws_vpc_peering_connection.this[*].id}"
  description = "The ID of the VPC Peering Connection"
}

output "peering_route_id" {
  value       = "${aws_route.peer_a[*].id}"
  description = "Route Table identifier and destination"
}

## VPN CONNECTION SITE-2-SITE OUTPUT ##
output "vpn_id" {
  value       = "${aws_vpn_connection.this[*].id}"
  description = "The amazon-assigned ID of the VPN connection"
}

output "vpn_type" {
  value       = "${aws_vpn_connection.this[*].type}"
  description = "The type of VPN connection"
}

output "vpn_vgw_id" {
  value       = "${aws_vpn_connection.this[*].vpn_gateway_id}"
  description = "The ID of the virtual private gateway to which the connection is attached"
}

output "vpn_cgw_id" {
  value       = "${aws_vpn_connection.this[*].customer_gateway_id}"
  description = "The ID of the customer gateway to which the connection is attached"
}

output "vpn_tunnel1_address" {
  value       = "${aws_vpn_connection.this[*].tunnel1_address}"
  description = "The public IP address of the first VPN tunnel"
}

output "vpn_tunnel1_cgw_inside_address" {
  value       = "${aws_vpn_connection.this[*].tunnel1_cgw_inside_address}"
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side)"
}

output "vpn_tunnel1_vgw_inside_address" {
  value       = "${aws_vpn_connection.this[*].tunnel1_vgw_inside_address}"
  description = "The RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side)"
}

output "vpn_tunnel1_preshared_key" {
  value       = "${aws_vpn_connection.this[*].tunnel1_preshared_key}"
  description = "The preshared key of the first VPN tunnel"
}

output "vpn_tunnel2_address" {
  value       = "${aws_vpn_connection.this[*].tunnel2_address}"
  description = "The public IP address of the first VPN tunnel"
}

output "vpn_tunnel2_cgw_inside_address" {
  value       = "${aws_vpn_connection.this[*].tunnel2_cgw_inside_address}"
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side)"
}

output "vpn_tunnel2_vgw_inside_address" {
  value       = "${aws_vpn_connection.this[*].tunnel2_vgw_inside_address}"
  description = "The RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side)"
}

output "vpn_tunnel2_preshared_key" {
  value       = "${aws_vpn_connection.this[*].tunnel2_preshared_key}"
  description = "The preshared key of the first VPN tunnel"
}

## ROUTE TABLE PRIVATE OUTPUT ##
output "rt_private_id" {
  value       = "${aws_route_table.private[*].id}"
  description = "The ID of the routing table"
}

## ROUTE TABLE PUBLIC OUTPUT ##
output "rt_public_id" {
  value       = "${aws_route_table.public.id}"
  description = "The ID of the routing table"
}

## SECURITY GROUP OUTPUT ##
output "sg_id" {
  value       = "${aws_security_group.this[*].id}"
  description = "The ID of the security group"
}

output "sg_arn" {
  value       = "${aws_security_group.this[*].arn}"
  description = "The ARN of the security group"
}

output "sg_vpc_id" {
  value       = "${aws_security_group.this[*].vpc_id}"
  description = "The VPC ID of the security group"
}

output "sg_name" {
  value       = "${aws_security_group.this[*].name}"
  description = "The NAME of the security group"
}

output "sg_ingress" {
  value       = "${aws_security_group.this[*].ingress}"
  description = "The Ingress rules of the security group"
}

output "sg_egress" {
  value       = "${aws_security_group.this[*].egress}"
  description = "The Egress rules of the security group"
}

## ELASTIC IP OUTPUT ##
output "eip_id" {
  value       = "${aws_eip.this[*].id}"
  description = "The ID of the EIP"
}
output "eip_public_ip" {
  value       = "${aws_eip.this[*].public_ip}"
  description = "The Public IP of the EIP"
}