# Deploy EC2 with User Data Script 
# Launch an EC2 instance and run a user data script to install and configure Nginx or Apache 
# automatically. 
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

resource "aws_instance" "myinstance" {
  ami= "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]
  user_data = <<-EOF
            #!/bin/bash
            sudo dnf install nginx -y
            systemctl start nginx
            EOF
    tags = {
      Name="nginx"
    }
}
resource "aws_security_group" "sg1" {
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
    Name="Nginx"
  }
}

#target group
resource "aws_lb_target_group" "aws-target-grp" {
  name = "demo-target-group"
  protocol = "http"
  ip_address_type = "ipv4"
  
}