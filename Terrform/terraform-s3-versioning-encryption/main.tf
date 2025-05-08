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


resource "aws_s3_bucket" "versioning-bucket" {
  bucket = "my-bucket-22233"
  versioning {
    enabled = true
    mfa_delete = false
  }
  
}
resource "aws_s3_object" "objetsc" {
  bucket= aws_s3_bucket.versioning-bucket.id
  content_type = "images/banner.png"
  key= "./banner.png"
  source ="banner.png" 
}



