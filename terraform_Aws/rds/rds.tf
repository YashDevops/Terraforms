#Parameter Group

resource "aws_db_parameter_group" "maria-db" {
  name        = "maria-db-parameter-group"
  family      = "mariadb10.1"
  description = "mariadb Parameter Group"

  parameter = {
    name  = "max_allowed_packet"
    value = "1677216"
  }
}

resource "aws_db_subnet_group" "maria-db-subnet" {
  name        = "maria-db-subnet"
  description = "RDS Subnet"
  subnet_ids  = ["${aws_subnet.main-private-1.id}", "${aws_subnet.main-private-2.id}"]
}

resource "aws_db_instance" "maria-db" {
  allocated_storage       = 100
  engine                  = "mariadb"
  engine_version          = "10.1.14"
  instance_class          = "db.t2.small"
  identifier              = "maria-db"
  name                    = "mariadb"
  username                = "root"
  password                = "${var.password}"
  db_subnet_group_name    = "${aws_db_subnet_group.maria-db-subnet.name}"
  parameter_group_name    = "${aws_db_parameter_group.maria-db.name}"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.rds_Security_group.id}"]
  storage_type            = "gp2"
  backup_retention_period = "30"

  tags {
    Name = "RDS Instances"
  }
}
