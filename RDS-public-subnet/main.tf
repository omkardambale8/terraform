terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Use latest stable version unless you have a reason to pin a specific one
    }
  }

  required_version = ">= 1.3.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "Postgres123" {
  engine = "Postgres"
  identifier = "rdsdb"
  skip_final_snapshot = true
  username = "Omkar"
  password = "password123"
  instance_class = "db.t4g.micro"
  allocated_storage = 20
  multi_az = true
  port=5432
  deletion_protection = false
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.subnet-grp.id
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  db_name = "aws"
  tags = {
    Name= "MyPostgresInstance"
  }

}

#dbsubnet-group

resource "aws_db_subnet_group" "subnet-grp" {
  subnet_ids = [aws_subnet.Private-subnet2.id,aws_subnet.Private-subnet1.id]
  tags = {
    Name= "subnet-grp"
  }
}

#security Group
resource "aws_security_group" "SG"{
  vpc_id = aws_vpc.RDS-VPC.id
  ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name= "security-grp"
  }
}


#security Group RDS
resource "aws_security_group" "rds-sg" {
  vpc_id = aws_vpc.RDS-VPC.id

  ingress {
    to_port = 5432
    from_port = 5432
    protocol = "tcp"
    security_groups= [aws_security_group.SG.id]
    description= "Allow PostgreSQL from EC2 SG"
  }

  egress{
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name= "security-grp-rds"
  }
}