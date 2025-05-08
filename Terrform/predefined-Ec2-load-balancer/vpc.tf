resource "aws_vpc" "lb-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="Lb-VPC"
  }
}

resource "aws_subnet" "pub-subnet1" {
    vpc_id = aws_vpc.lb-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name="Public-subnet1"
    }
}
resource "aws_subnet" "pub-subnet2" {
    vpc_id = aws_vpc.lb-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      Name="Public-subnet2"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.lb-vpc.id
  tags = {
    Name="internet-gatway-01"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.lb-vpc.id
  route{
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id

  }
  tags = {
    Name= "Routing table-subs"
  }
}

resource "aws_route_table_association" "association" {
  subnet_id = aws_subnet.pub-subnet2.id
  route_table_id = aws_route_table.route-table.id

}
resource "aws_route_table_association" "association2" {
  subnet_id = aws_subnet.pub-subnet1.id
  route_table_id = aws_route_table.route-table.id
}