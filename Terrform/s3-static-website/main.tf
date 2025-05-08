#Deploy a Static Website on S3 
#Host a static HTML/CSS website using S3 with public access, static hosting settings, and 
#optional Route53 DNS.

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

resource "aws_s3_bucket" "mybucket" {
  bucket = "new-year-bucker-1122"
  }

resource "aws_s3_object" "my-bucket-obj" {
  bucket = aws_s3_bucket.mybucket.id
  content_type = "text/html"
  key = "./index.html"
  source = "index.html"
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "webapp" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode(
    {
    Version= "2012-10-17",
    Statement= [
        {
            Sid= "PublicReadGetObject",
            Effect= "Allow",
            Principal= "*",
            Action= "s3:GetObject"
            Resource= "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
            
        }
    ]
})
}
resource "aws_s3_bucket_website_configuration" "myobj" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

    
}