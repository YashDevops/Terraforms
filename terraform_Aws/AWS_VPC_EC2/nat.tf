#this will create a nat gateway
resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${aws_subnet.main-public-1.id}"
  depends_on    = ["aws_internet_gateway.main-gw"]
}

#VPC Setup for NAT

resource "aws_route_table" "main-private-1" {
  vpc_id = "${aws_vpc.main.id}"

  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  tags {
    Name = "Nat Association with private instances"
  }
}

#nat Association wiht private network
resource "aws_route_table_association" "main-private-1" {
  route_table_id = "${aws_route_table.main-private-1.id}"
  subnet_id      = "${aws_subnet.main-private-1.id}"
}

resource "aws_route_table_association" "main-private-2" {
  route_table_id = "${aws_route_table.main-private-1.id}"
  subnet_id      = "${aws_subnet.main-private-2.id}"
}
