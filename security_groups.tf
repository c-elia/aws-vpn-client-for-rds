resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Restrict access within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-security-group"
  }
}


resource "aws_security_group" "vpn" {
  name        = "${var.project}-sg-vpn"
  vpc_id      = aws_vpc.vpc.id
  description = "Allow access to client VPN"

  ingress {
    description = "Access to client VPN"
    protocol    = "tcp"
    from_port   = var.database["port"]
    to_port     = var.database["port"]
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  egress {
    description      = "Egress traffic from client VPN"
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:aws-vpc-no-public-egress-sgr
  }

}
