resource "aws_vpc" "f5-xc-spoke" {
  cidr_block           = var.spokeVpcCidrBlock
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-vpc-2"
  }
}

resource "aws_subnet" "f5-xc-spoke-external" {
  vpc_id                  = aws_vpc.f5-xc-spoke.id
  for_each                = var.spokeVpc.external
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.spokeVpc.azs[each.key]["az"]

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-external-${each.key}-2"
  }
}

resource "aws_subnet" "f5-xc-spoke-internal" {
  vpc_id                  = aws_vpc.f5-xc-spoke.id
  for_each                = var.spokeVpc.internal
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.spokeVpc.azs[each.key]["az"]

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-external-${each.key}-2"
  }
}

resource "aws_subnet" "f5-xc-spoke-workload" {
  vpc_id                  = aws_vpc.f5-xc-spoke.id
  for_each                = var.spokeVpc.workload
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.spokeVpc.azs[each.key]["az"]

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-workload-${each.key}-2"
  }
}


resource "aws_internet_gateway" "f5-xc-spoke-vpc-gw" {
  vpc_id = aws_vpc.f5-xc-spoke.id

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-vpc-igw-2"
  }
}

resource "aws_route_table" "f5-xc-spoke-vpc-external-rt" {
  vpc_id = aws_vpc.f5-xc-spoke.id

  tags = {
    Name = "${var.projectPrefix}-f5-xc-spoke-external-rt-2"
  }
}

resource "aws_route" "spoke-myip-rt" {
  route_table_id         = aws_route_table.f5-xc-spoke-vpc-external-rt.id
  destination_cidr_block = "${chomp(data.http.f5-xc-http-myip.body)}/32"
  gateway_id             = aws_internet_gateway.f5-xc-spoke-vpc-gw.id
  depends_on             = [aws_route_table.f5-xc-spoke-vpc-external-rt]
}

resource "aws_route" "spoke-internet-rt" {
  route_table_id         = aws_route_table.f5-xc-spoke-vpc-external-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.f5-xc-spoke-vpc-gw.id
  depends_on             = [aws_route_table.f5-xc-spoke-vpc-external-rt]
}

resource "aws_route_table_association" "f5-xc-spoke-external-association" {
  for_each       = aws_subnet.f5-xc-spoke-external
  subnet_id      = each.value.id
  route_table_id = aws_route_table.f5-xc-spoke-vpc-external-rt.id
}

resource "aws_security_group" "f5-xc-spoke-vpc" {
  name   = "${var.projectPrefix}-f5-xc-spoke-sg-2"
  vpc_id = aws_vpc.f5-xc-spoke.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.64.0.0/10"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.trusted_ip]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.f5-xc-http-myip.body)}/32"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["122.182.197.13/32"] # Bangalore
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["14.97.165.0/24"]  # Bangalore
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
