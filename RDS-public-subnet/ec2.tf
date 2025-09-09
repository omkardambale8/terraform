resource "aws_instance" "ec2-normal" {
  ami="ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Pub-subnet.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.SG.id]
  key_name = aws_key_pair.example.id
    tags = {
      Name= "EC2"
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

output "key" {
  value = aws_key_pair.example.public_key
}

/*
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWVKjGI9BwkCjxUXqt+hq6m9tgldWeuBHXCcoy1V+H5vFuZ/FzV0LlFQm38LHQyO5Z+9N1I6oohNkKLJPygM4lfPKQ+2LcC0tfPhlSKs81wK9WvchgSqJz/ZQcLKKsOkCAF1HOp2uZF8X+soc8vTrJK/SGLvzNHBkrvcFziirv0NA5oIlZLB1GnkWXImNqH3aOBSMqmXU3VWqW+v2X8PFGagFXxa3YMo3FljMwuJ5F2Q7w5NLWi1djhWvMwbcyGY/rSIZqcOqmHPWteEem85vqyxCINKR2Pl5I263y0G6HaX0opYOBvxmhQ4TXWkKbi1Q3PHOz0LlatArDO2amcBDjPt5OKMGJcpBxz9tEHKn6e3/vCIs2IS6G5L2GP1Pb7XrYS7/8nEWDVpb8t5vLmW6P3TpZXx3D1x9FOh72iENWyy1CZBgo6sTDG1GCgw5qayi7Wre4rVFXWMsLv2cIjBfyzRBR/x3XiohWmCz52KLCuLPq0aNi7J1hTxjxtD1y0UJou2alI0RJFlo38SO8sXpGyLyg6JkVPdj6HcKfZmeqIh+WhqGMyBN+E6rHAw8RQ==
*/