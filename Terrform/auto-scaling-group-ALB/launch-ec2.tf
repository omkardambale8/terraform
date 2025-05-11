resource "aws_launch_template" "Template" {
  name = "ASG-group-template"
  instance_type = "t2.micro"
  image_id = "ami-0f88e80871fd81e91"
  network_interfaces {
    security_groups = [aws_security_group.ASG-sg.id]
    associate_public_ip_address = true
    subnet_id = aws_subnet.subnet1.id #added VPC
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10    # Size in GiB
      volume_type = "gp2"   # General Purpose SSD
      delete_on_termination = true 
    }
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello world by omkar" > /var/www/html/index.html

              EOF
  )

  tags = {
    name="ASG-group-template"
  }
}

    