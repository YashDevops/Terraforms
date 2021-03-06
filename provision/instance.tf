resource "aws_key_pair" "mykey" {
	key_name="mykey",
	public_key="${file("${var.PATH_PUBLIC_KEY}")}"
}

resource "aws_instance" "example"{
	ami="ami-0552e3455b9bc8d50",
	instance_type="t2.micro"
	key_name="${aws_key_pair.mykey.key_name}"
	
	provisioner "file"{
		source="script.sh"
		destination="/tmp/script.sh"
		}

	provisioner "remote-exec"{
		inline=["chmod +x /tmp/script.sh","sudo /tmp/script.sh"]
		}


	connection {
		user="${var.username}"
		private_key="${file("${var.PATH_PRIVATE_KEY}")}"
	}
}