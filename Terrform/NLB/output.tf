output "VPC-Cidr" {
  value =aws_vpc.myvpc.cidr_block
}

output "subnet-ID" {
  value =aws_subnet.subnet1.id 
}

output "subnet-IDs" {
  value =aws_subnet.subnet2.id
  }

  output "instance-public-ip" {
    value = aws_instance.ec2-nlb[*].public_ip
  }

  
  output "DNS-NLB" {
   value = aws_lb.NLB-lb.dns_name
  }
  #10.0.0.0/16

