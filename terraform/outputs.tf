# validation task

# default VPC id 

output "vpc_id" {
  value = "${data.aws_vpc.default.id}"
}

# default subnet id 

output "subnet_id" {
  value = "${data.aws_subnet.default.id}"
}


# created server instance id 

output "mediawiki_server_id" {
  value = "${aws_instance.mediawiki.id}"
}

# created server public dns name

output "mediawiki_server_public_dns" {
  value = "${aws_instance.mediawiki.public_dns}"
}

# instance state

output "mediawiki_server_state" {
  value = "${aws_instance.mediawiki.instance_state}"
}
