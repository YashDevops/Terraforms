resource "aws_security_group" "myexample_Security_group" {
  vpc_id      = "${aws_vpc.mydemovpc.id}"
  name        = "allow_ssh"
  description = "This security group is for the aws instance"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws_instance_Security_group"
  }
}

resource "aws_security_group" "rds_Security_group" {
  vpc_id = "${aws_vpc.mydemovpc.id}"
  name   = "Maria Db"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.myexample_Security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = "true"
  }

  tags {
    Name = "MAriadb_RDS"
  }
}
