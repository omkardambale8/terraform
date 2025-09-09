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

resource "aws_autoscaling_group" "ASG" {
 max_size = 2
 min_size = 1
 vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
 target_group_arns =[aws_lb_target_group.ASG-tg.arn]
 launch_template{
  id = aws_launch_template.Template.id
  version = "$Latest"
 }
 tag {
   key = "Name"
   value = "Web-asg"
   propagate_at_launch = true
 }
}

output "aws-aws_autoscaling_group" {
  value = aws_autoscaling_group.ASG.name
}