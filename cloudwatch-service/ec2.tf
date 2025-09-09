resource "aws_instance" "monitored_ec2" {
  ami                    = "ami-0e449927258d45bc4" # Amazon Linux 2
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.example.id
  iam_instance_profile   = aws_iam_instance_profile.cw_agent_profile.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("install.sh")

  tags = {
    Name = "MonitoredInstance"
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

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow SSH and CW Agent"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}
