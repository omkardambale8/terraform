resource "aws_instance" "ec2-nlb" {
  count = var.instance-count
  ami = "ami-084a7d336e816906b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  key_name = aws_key_pair.example.id
  security_groups = [aws_security_group.s_group.id]
  associate_public_ip_address = true  
  user_data = <<-EOF
            #!/bin/bash
            dnf install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx

            echo "Hello from NGINX on Default VPC!" > /var/www/html/index.html
            EOF
    tags = {
      Name=var.instance-name[count.index]
    }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = tls_private_key.example.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

