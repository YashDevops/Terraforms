resource "aws_key_pair" "mykey"{
	key_name="ShahDevops.pem"
	public_key="${file("${var.PATH_PUBLIC}")}"	
}


resource "aws_instance" "example"{
	ami="ami-0552e3455b9bc8d50"
	instance_type="t2.micro"

	provisioner "file"{
	source = "scritp.sh"
	destination="/home/ubuntu/scritp.sh"
	}
	provisioner "remote-exec"{
	inline=[
		"chmod +x /home/ubuntu/scritp.sh","sudo /home/ubuntu/scritp.sh" 
		]
	}
	connection {
	user="${var.USERNAME}"
	private_key="${file("${var.PATH_PRIVATE}")}"
	}
}