terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id= "my-redis"
  description = "Redis replication group with HA"

  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.t2.micro"
  num_cache_clusters = 1
  port = 6379


  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [ aws_security_group.ellasticache-SG.id ]
  depends_on = [ aws_elasticache_subnet_group.redis_subnet_group ]

}

# Subnet Group for Redis
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.public-subnet1.id,aws_subnet.public-subnet2.id]
}







