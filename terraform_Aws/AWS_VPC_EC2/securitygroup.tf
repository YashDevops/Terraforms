resource "aws_security_group" "allow_ssh" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "Allow_SSH"
  description = "This is a security group created by terraform which will allow you to perform ssh only"

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Allow_SSH"
  }
}
