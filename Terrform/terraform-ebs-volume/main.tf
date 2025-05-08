#Create and Attach an EBS Volume 
#Provision and attach additional EBS storage to an EC2 instance, using Terraform volume 
#resources. 
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

resource "aws_instance" "instance" {
    ami = "ami-0e449927258d45bc4"
    instance_type = "t2.micro"  
    tags = {
      Name= "Ec2"
    }
}
resource "aws_ebs_volume" "ebs-aws-vol" {
  type = "gp3"
  size = 20
  iops = 300
  availability_zone = "us-east-1a"
  tags = {
    Name= "Ebs-Vol"
  }
}

resource "aws_volume_attachment" "attachment" {
  device_name = "/dev/sdh"
  instance_id= aws_instance.instance.id
  volume_id = aws_ebs_volume.ebs-aws-vol.id
  force_detach = true
  
}