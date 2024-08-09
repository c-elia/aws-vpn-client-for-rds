resource "aws_subnet" "sb-private-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets["sb-private-1"]
  availability_zone = data.aws_availability_zones.zones.names[0]

  tags = {
    Name = "sb-private-1"
  }
}

resource "aws_subnet" "sb-private-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets["sb-private-2"]
  availability_zone = data.aws_availability_zones.zones.names[1]

  tags = {
    Name = "sb-private-2"

  }
}

resource "aws_subnet" "sb-private-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets["sb-private-3"]
  availability_zone = data.aws_availability_zones.zones.names[2]

  tags = {
    Name = "sb-private-3"
  }
}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds-db-subnet-group"
  subnet_ids = [aws_subnet.sb-private-1.id, aws_subnet.sb-private-2.id, aws_subnet.sb-private-3.id]

  tags = {
    Name = "rds-db-subnet-group"
  }
}
