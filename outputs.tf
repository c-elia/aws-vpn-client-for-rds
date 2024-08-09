output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "sb-private-1" {
  value = aws_subnet.sb-private-1.id
}

output "sb-private-2" {
  value = aws_subnet.sb-private-2.id
}

output "sb-private-3" {
  value = aws_subnet.sb-private-2.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}

output "vpn_security_group_id" {
  value = aws_security_group.vpn.id
}


output "rds_endpoint" {
  value = aws_db_instance.database.endpoint
}

output "rds_instance_id" {
  value = aws_db_instance.database.id
}

output "vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.vpn.client_cidr_block
}

output "vpn_endpoint_dns_name" {
  value = aws_ec2_client_vpn_endpoint.vpn.dns_name
}
