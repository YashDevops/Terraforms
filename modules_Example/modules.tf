module "consul"{
	source = "github.com/IGNW/terraform-aws-jenkins.git"
	key_name="mykey"
	key_path="${file("${var.path_to_private_key}")}"
}
output "consul_output"{
	value="${module.consul.server_address}"
}