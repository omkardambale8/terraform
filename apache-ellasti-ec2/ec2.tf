resource "aws_instance" "myec2" {
  ami = "ami-020cba7c55df1f615" #ubuntu
  instance_type = "t2.micro"
  key_name = aws_key_pair.example.id
  subnet_id = aws_subnet.public-subnet2.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.aws-sg.id
  ]

  tags = {
    Name= "My-EC2"
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

resource "aws_security_group" "aws-sg" {
  vpc_id = aws_vpc.vpc01.id
  

  ingress {
    #ssh protocol
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 } 
 tags = {
   Name= "ellasticache"
 }
}

resource "aws_security_group" "ellasticache-SG" {
  vpc_id = aws_vpc.vpc01.id
  ingress {
    #http protocol
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_groups = [ aws_security_group.aws-sg.id ]
    description= "Allow ellasticache from EC2 SG"

  } 

  egress{
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  } 

}
