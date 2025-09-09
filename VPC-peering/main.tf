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

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags={
    Name="vpc1"
  } 
  }

  resource "aws_subnet" "subnet-vpc1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name="Subnet1-vpc1"
    }
  }

  resource "aws_route_table" "vpc1-rt" {
    vpc_id = aws_vpc.vpc1.id
    tags = {

      Name="vpc1-rt"
    }
  }

  resource "aws_route_table_association" "routetable-vpco-ass1" {
    subnet_id = aws_subnet.subnet-vpc1.id
    route_table_id = aws_route_table.vpc1-rt.id
    
      }





  resource "aws_vpc" "vpc2" {
  cidr_block = "11.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags={
    Name="vpc2"
  } 
  }

  resource "aws_subnet" "subnet-vpc2" {
    vpc_id = aws_vpc.vpc2.id
    cidr_block = "11.0.2.0/24"
    tags = {
      Name="Subnet1-vpc2"
    }
  }

  resource "aws_route_table" "vpc2-rt" {
    vpc_id = aws_vpc.vpc2.id
    tags = {

      Name="vpc2-rt"
    }
  }

  resource "aws_route_table_association" "routetable-vpct-ass" {
    subnet_id = aws_subnet.subnet-vpc2.id
    route_table_id = aws_route_table.vpc2-rt.id

  }


#vpc peering

resource "aws_vpc_peering_connection" "peer" {
  vpc_id =aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
}

resource "aws_route" "a-b" {
    route_table_id = aws_route_table.vpc1-rt.id
    destination_cidr_block = aws_vpc.vpc2.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
resource "aws_route" "b-a" {
    route_table_id = aws_route_table.vpc2-rt.id
    destination_cidr_block = aws_vpc.vpc1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}