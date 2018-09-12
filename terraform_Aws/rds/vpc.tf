resource "aws_vpc" "mydemovpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
}

resource "aws_subnet" "main-public-1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.mydemovpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags {
    Name = "Public_Facing(Main-Public-1)"
  }
}

resource "aws_subnet" "main-private-1" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = "${aws_vpc.mydemovpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags {
    Name = "Private_Facing(Main-Private-1)"
  }
}

resource "aws_subnet" "main-private-2" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = "${aws_vpc.mydemovpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.mydemovpc.id}"

  tags {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.mydemovpc.id}"

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags {
    Name = "Route _table"
  }
}

resource "aws_route_table_association" "main-public-1" {
  subnet_id      = "${aws_subnet.main-public-1.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
