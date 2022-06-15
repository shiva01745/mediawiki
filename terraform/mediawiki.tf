terraform {
  required_version = "~> 1.2.2"
  required_providers {
    aws = {

      source  = "hashicorp/aws"
      version = "~> 3.74.0"
    }
  }
}

# considered aws cloud

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


# using default vpc instead of creating a new one

data "aws_vpc" "default" {
  default = true
}


# using default subnet instead of creating a new one

data "aws_subnet" "default" {
  vpc_id            = "${data.aws_vpc.default.id}"
  default_for_az    = true
  availability_zone = "us-east-1a"
}

# Create Security group for aws server for ports 80 & 22

resource "aws_security_group" "mediawiki_sg" {
  name        = "mediawiki__sg"
  vpc_id      = "${data.aws_vpc.default.id}"
  description = "mediawiki Security Group"

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# create aws server for hosting mediawiki application

resource "aws_instance" "mediawiki" {
  ami                    = "ami-0b0af3577fe5e3532"
  subnet_id              = "${data.aws_subnet.default.id}"
  vpc_security_group_ids = [aws_security_group.mediawiki_sg.id]
  instance_type = "t2.micro"
  key_name      = "ubuntu_key"

  tags = {
    Env  = "POC"
    Name = "mediawiki_server"
  }
   provisioner "remote-exec" {
    inline = [
      "sleep 160",
      "sudo dnf install python3 -y",
    ]
  }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("../key/ubuntu_key.pem")
      timeout     = "4m"
   }

}


# using ansible for install and configure mediawiki application

resource "null_resource" "example1" {
  provisioner "local-exec" {
        command = <<EOF
        sleep 30;
        echo [web] > inv;
        echo ${aws_instance.mediawiki.public_dns} >> inv;
        export ANSIBLE_HOST_KEY_CHECKING=False;
        ansible-playbook -u ec2-user --private-key ../key/ubuntu_key.pem -i inv ../ansible_playbook/mediawiki_playbook.yml
    EOF
  }
}
