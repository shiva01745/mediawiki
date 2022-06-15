terraform {
  required_version = "~> 1.1.0"
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.74.0"
      }
  }
}


provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "ec2_jboss" {
  ami = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
}

output "op" {
  value = aws_instance.ec2_jboss.public_ip
}
