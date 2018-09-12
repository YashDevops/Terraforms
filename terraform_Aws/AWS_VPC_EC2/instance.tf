resource "aws_instance" "example1" {
  ami           = "ami-0552e3455b9bc8d50"
  instance_type = "t2.micro"

  tags {
    Name       = "Instance 1 Public Facing"
    Created_by = "Hashicorp Terraform"
  }

  subnet_id = "${aws_subnet.main-public-1.id}"

  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  key_name = "${aws_key_pair.mykey.key_name}"
}

resource "aws_instance" "example2" {
  ami           = "ami-0552e3455b9bc8d50"
  instance_type = "t2.micro"

  tags = {
    Name       = "Instance 2 private"
    Created_by = "Hashicorp Terraform"
  }

  subnet_id              = "${aws_subnet.main-private-1.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name               = "${aws_key_pair.mykey.key_name}"
}
