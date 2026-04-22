resource "aws_vpc" "prod" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    name = "demo_vpc"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.prod.id
  availability_zone = var.sub1_az
  cidr_block= var.sub1_cidr
  tags = {
    name ="public-sub1"
  }
}

resource "aws_internet_gateway" "prod_ig" {
  vpc_id = aws_vpc.prod.id
  tags = {
    name = "prod-igw"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.prod.id

  route {
    gateway_id = aws_internet_gateway.prod_ig.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.sub1.id
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.prod.id
  availability_zone = var.sub2_az
  cidr_block = var.sub2_cidr
  tags = {
    name = "prod_sub2"
  }
}

resource "aws_eip" "aws_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.aws_eip.id
  subnet_id = aws_subnet.sub2.id
  tags = {
    name = "nat_gateway"
  }
  depends_on = [ aws_internet_gateway.prod_ig.id ]
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}
resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.rt2
  subnet_id = aws_subnet.sub2
}

resource "aws_security_group" "asg" {
  name = "security group"
  description = "security_group"
  vpc_id = aws_vpc.prod.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0"  ]
  }
  tags = {
    name = "sec_grp"
  }
}

