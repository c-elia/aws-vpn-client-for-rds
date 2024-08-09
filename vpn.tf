resource "aws_ec2_client_vpn_endpoint" "vpn" {
  description            = "VPN endpoint for my RDS"
  server_certificate_arn = var.vpn_certificate_arn
  client_cidr_block      = var.vpn_client_cidr_block
  split_tunnel           = true
  vpc_id                 = aws_vpc.vpc.id
  security_group_ids     = [aws_security_group.vpn.id]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.vpn_certificate_arn
  }

  connection_log_options {
    enabled = false
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_vpc.vpc.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_network_association" "private-1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = aws_subnet.sb-private-1.id
}

resource "aws_ec2_client_vpn_network_association" "private-2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = aws_subnet.sb-private-2.id
}

resource "aws_ec2_client_vpn_network_association" "private-2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = aws_subnet.sb-private-3.id
}
