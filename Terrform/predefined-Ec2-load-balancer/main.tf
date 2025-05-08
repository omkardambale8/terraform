terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-instance" {
  ami= "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  
 subnet_id = aws_subnet.pub-subnet1.id
 key_name =  aws_key_pair.example.key_name
 vpc_security_group_ids = [ aws_security_group.sg.id ]
 user_data = <<-EOF
            #!/bin/bash
            sudo dnf install httpd -y
            systemctl start httpd
            EOF

 
  tags = {
    Name="EC2-lb"
  }

 }

output "aws_dns" {
  value= aws_lb.loadbalancer1.dns_name
}
 resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  key_name   = "my-key"
  public_key = tls_private_key.example.public_key_openssh
}



resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.lb-vpc.id
  
  ingress{
    to_port= 80
    from_port= 80
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress{
    to_port= 22
    from_port= 22
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  
  egress{
    to_port= 0
    from_port= 0
    protocol= -1
    cidr_blocks=["0.0.0.0/0"]

  }
  tags = {
    Name="N"
  }
}


