#this is for creating a vpc

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name       = "ShahVpc"
    Created_By = "HashiCorp Terraform"
    Purpose    = "InfraDevelopment"
  }
}

#creating subnets

#Public Subnet
resource "aws_subnet" "main-public-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"

  tags {
    Name       = "public-faced-2a"
    Created_By = "HashiCorp Terraform"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"

  tags {
    Name       = "public-faced-2b"
    Created_By = "HashiCorp Terraform"
  }
}

#Private Subnets
resource "aws_subnet" "main-private-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2a"

  tags {
    Name       = "Private-Faced-2a"
    Created_By = "HashiCorp Terraform"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2b"

  tags {
    Name       = "Private-Faced-2b"
    Created_By = "HashiCorp Terraform"
  }
}

#creating internet gateway

resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name         = "Internet Gateway Main"
    Attached_vpc = "${aws_vpc.main.tags.Name}"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags {
    Name = "aws route configuration"
  }
}
