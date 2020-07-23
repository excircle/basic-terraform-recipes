provider "aws" {
  region  = "us-east-2"
}

variable "kube_hostnames" {
  type = list(string)
  default = ["kube101.node.io"]
}
resource "aws_instance" "kube_instance" {
  for_each                = toset(var.kube_hostnames)
  ami                     = "ami-01e36b7901e884a10"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.instance.id]
  key_name                = "tpair1"
  user_data               = templatefile("./bootstrap.sh", { k_hostname = "${each.key}" })

  tags = {
    Name = "${each.key}"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform_sec_group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port    = 0
   to_port      = 0
   protocol     = "-1"
   cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_sec_group"
  }
}