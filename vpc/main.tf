## VPC RESOURCE ##
resource "aws_vpc" "this" {
  cidr_block           = lookup(element(var.vpc_options, 0), "cidr_block")
  enable_dns_support   = lookup(element(var.vpc_options, 0), "enable_dns_support")
  enable_dns_hostnames = lookup(element(var.vpc_options, 0), "enable_dns_hostnames")
  tags = merge(
    {
      Name = format("vpc-%s", var.context),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## SUBNET PRIVATE RESOURCE ##
resource "aws_subnet" "private" {
  count             = local.subnet_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(lookup(element(var.vpc_options, 0), "cidr_block"), 4, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 2 == 0 ? 0 : 1)
  tags = merge(
    {
      Name = format("subnet-%s-private-%s", var.context, count.index % 2 == 0 ? "zone-a" : "zone-b"),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## SUBNET PUBLIC RESOURCE ##
resource "aws_subnet" "public" {
  count             = local.subnet_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(lookup(element(var.vpc_options, 0), "cidr_block"), 8, "24${count.index}")
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 2 == 0 ? 0 : 1)
  tags = merge(
    {
      Name = format("subnet-%s-public-%s", var.context, count.index % 2 == 0 ? "zone-a" : "zone-b"),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## ELASTIC IP RESOURCE ##
resource "aws_eip" "this" {
  count = local.subnet_count
  vpc   = true
  tags = merge(
    {
      Name = format("eip-%s-%s", var.context, count.index % 2 == 0 ? "zone-a" : "zone-b"),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## NAT GATEWAY RESOURCE ##
resource "aws_nat_gateway" "this" {
  count         = local.subnet_count
  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(
    {
      Name = format("ngw-%s-%s", var.context, count.index % 2 == 0 ? "zone-a" : "zone-b"),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## ROUTE TABLE PRIVATE RESOURCE ##
resource "aws_route_table" "private" {
  count  = local.subnet_count
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }
  tags = merge(
    {
      Name = format("rt-%s-private-%s", var.context, count.index % 2 == 0 ? "zone-a" : "zone-b"),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
  lifecycle {
    ignore_changes = ["route"]
  }
}

resource "aws_route_table_association" "private" {
  count          = local.subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
  depends_on     = ["aws_subnet.private", "aws_route_table.private"]
}

## INTERNET GATEWAY RESOURCE ##
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      Name = format("igw-%s", var.context),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## VPN GATEWAY RESOURCE ##
resource "aws_vpn_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      Name = format("vgw-%s", var.context),
    },
    local.default_tags,
    lookup(element(var.vpc_options, 0), "extraTags")
  )
}

## DHCP OPTIONS RESOURCE ##
resource "aws_vpc_dhcp_options" "this" {
  count                = local.dhcp_count
  domain_name          = lookup(element(var.dhcp_options, 0), "domain_name")
  domain_name_servers  = lookup(element(var.dhcp_options, 0), "domain_name_servers")
  ntp_servers          = lookup(element(var.dhcp_options, 0), "ntp_servers")
  netbios_name_servers = lookup(element(var.dhcp_options, 0), "netbios_name_servers")
  netbios_node_type    = lookup(element(var.dhcp_options, 0), "netbios_node_type")
  tags = merge(
    {
      Name = format("dhcp-option-%s", var.context),
    },
    local.default_tags,
    lookup(element(var.dhcp_options, 0), "extraTags")
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count           = local.dhcp_count
  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this[count.index].id
}

## PEERING RESOURCE ##
resource "aws_vpc_peering_connection" "this" {
  count         = local.peer_count
  peer_owner_id = lookup(element(var.peer_options, count.index), "peer_account_id")
  peer_vpc_id   = lookup(element(var.peer_options, count.index), "peer_vpc_id")
  peer_region   = lookup(element(var.peer_options, count.index), "peer_region")
  vpc_id        = aws_vpc.this.id
  auto_accept   = lookup(element(var.peer_options, count.index), "auto_accept")
  tags = merge(
    {
      Name = format("pcx-%s-%s", var.context, lookup(element(var.peer_options, count.index), "peer_destination_context_name")),
    },
    local.default_tags,
    lookup(element(var.peer_options, count.index), "extraTags")
  )
}

resource "aws_route" "peer_a" {
  count                     = local.peer_count
  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = lookup(element(var.peer_options, count.index), "peer_destination_cidr_block")
  vpc_peering_connection_id = aws_vpc_peering_connection.this[count.index].id
  depends_on                = ["aws_route_table.private", "aws_vpc_peering_connection.this"]
}

resource "aws_route" "peer_b" {
  count                     = var.environment == "prod" ? local.peer_count : 0
  route_table_id            = aws_route_table.private[1].id
  destination_cidr_block    = lookup(element(var.peer_options, count.index), "peer_destination_cidr_block")
  vpc_peering_connection_id = aws_vpc_peering_connection.this[count.index].id
  depends_on                = ["aws_route_table.private", "aws_vpc_peering_connection.this"]
}

## VPN CONNECTION SITE-2-SITE RESOURCE ##
resource "aws_customer_gateway" "this" {
  count      = local.vpn_count
  bgp_asn    = lookup(element(var.vpn_options, count.index), "cgw_bgp_asn")
  ip_address = lookup(element(var.vpn_options, count.index), "cgw_ip_address")
  type       = lookup(element(var.vpn_options, count.index), "cgw_type")
  tags = merge(
    {
      Name = format("cgw-%s-%s", var.context, lookup(element(var.vpn_options, count.index), "vpn_destination_context_name")),
    },
    local.default_tags,
    lookup(element(var.vpn_options, count.index), "extraTags")
  )
}
resource "aws_vpn_connection" "this" {
  count               = local.vpn_count
  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this[count.index].id
  type                = lookup(element(var.vpn_options, count.index), "vpn_type")
  static_routes_only  = true
  tags = merge(
    {
      Name = format("vpn-%s-%s", var.context, lookup(element(var.vpn_options, count.index), "vpn_destination_context_name")),
    },
    local.default_tags,
    lookup(element(var.vpn_options, count.index), "extraTags")
  )
  depends_on = ["aws_customer_gateway.this", "aws_vpn_gateway.this"]
}

resource "aws_vpn_connection_route" "this" {
  count                  = local.vpn_count
  destination_cidr_block = "0.0.0.0/0"
  vpn_connection_id      = aws_vpn_connection.this[count.index].id
}

## ROUTE TABLE PUBLIC RESOURCE ##
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  dynamic route {
    iterator = cidr_block
    for_each = lookup(element(var.rt_public_options, 0), "destination_cidr_block")
    content {
      cidr_block = cidr_block.value
      gateway_id = cidr_block.value == "0.0.0.0/0" ? aws_internet_gateway.this.id : aws_vpn_gateway.this.id
    }
  }
  tags = merge(
    {
      Name = format("rt-%s-public", var.context),
    },
    local.default_tags,
    lookup(element(var.rt_public_options, 0), "extraTags")
  )
}

resource "aws_route_table_association" "this" {
  count          = local.subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  depends_on     = ["aws_subnet.public", "aws_route_table.public"]
}

## SECURITY GROUP RESOURCE ##
resource "aws_security_group" "this" {
  count       = local.sg_count
  name        = lookup(element(var.sg_options, count.index), "name")
  description = lookup(element(var.sg_options, count.index), "desc")
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = [for ingress in lookup(element(var.sg_options, count.index), "sg_ingress") : {
      from_port   = ingress.from_port
      to_port     = ingress.to_port
      protocol    = ingress.protocol
      cidr_blocks = ingress.cidr_blocks
    }]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = [for egress in lookup(element(var.sg_options, count.index), "sg_egress") : {
      from_port   = egress.from_port
      to_port     = egress.to_port
      protocol    = egress.protocol
      cidr_blocks = egress.cidr_blocks
    }]
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    {
      Name = lookup(element(var.sg_options, count.index), "name"),
    },
    local.default_tags,
    lookup(element(var.sg_options, count.index), "extraTags")
  )
}
