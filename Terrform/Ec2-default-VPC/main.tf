#1. Launch EC2 Instance in a Default VPC
# Provision a basic EC2 instance using Terraform with 
# default network settings and SSH access.
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

resource "aws_instance" "myec2" {
  ami= "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  count = 2
  
}