resource "aws_instance" "example" {
  ami             = "ami-04169656fea786776"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.myexample_Security_group.id}"]
  key_name        = "${aws_key_pair.mykey.key_name}"
  subnet_id       = "${aws_subnet.main-public-1.id}"
}
