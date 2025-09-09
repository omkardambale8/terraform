resource "aws_vpc" "RDS-VPC" {
  cidr_block = "10.0.0.0/16" 
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name= "RDS-VPC"
  }

}
#Pub-subnet
resource "aws_subnet" "Pub-subnet" {
  vpc_id = aws_vpc.RDS-VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone       = "us-east-1b"  # Subnet in AZ A
  map_public_ip_on_launch = true
  tags = {
    Name= "Public-subnet"
  }

}
#Private-subnet
resource "aws_subnet" "Private-subnet1" {
  vpc_id = aws_vpc.RDS-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"  # Subnet in AZ A
  map_public_ip_on_launch = false
  tags = {
    Name= "Private-subnet1"
  }

}
resource "aws_subnet" "Private-subnet2" {
  vpc_id = aws_vpc.RDS-VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"  # Subnet in AZ A
  map_public_ip_on_launch = false
  tags = {
    Name= "Private-subnet2"
  }

}
resource "aws_internet_gateway" "internet-gtw" {
  vpc_id = aws_vpc.RDS-VPC.id
  tags = {
    Name= "Internet-gtw1"
  }
}

resource "aws_nat_gateway" "NAT-gtw" {
  subnet_id = aws_subnet.Pub-subnet.id
  allocation_id = aws_eip.eip1.id
  tags = {
    Name= "Nat-Gateway"
  }
    depends_on = [ aws_internet_gateway.internet-gtw]

}

resource "aws_eip" "eip1" {
  vpc=true
  tags = {
    Name = "RDS-eip"
  }

}



resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.RDS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gtw.id

  }
  tags = {
    Name= "Public-RT"
  }
}

resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.RDS-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT-gtw.id
    
  }
  tags = {
    Name= "Private-RT"
  }
}

resource "aws_route_table_association" "Pub-ass" {
  subnet_id = aws_subnet.Pub-subnet.id
  route_table_id = aws_route_table.Public-RT.id
}

resource "aws_route_table_association" "private-ass1" {
  subnet_id = aws_subnet.Private-subnet1.id
  route_table_id =aws_route_table.Private-RT.id
}
resource "aws_route_table_association" "private-ass2" {
  subnet_id = aws_subnet.Private-subnet2.id
  route_table_id =aws_route_table.Private-RT.id
}