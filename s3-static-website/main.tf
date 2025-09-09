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


resource "aws_s3_bucket" "source" {
  bucket = "new-year-bucker-11221new"
  versioning {
    enabled = true
  }
  }

resource "aws_s3_bucket_versioning" "source-versioning" {
  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}

/*
resource "aws_s3_bucket_object" "obj" {
  bucket = aws_s3_bucket.source.id
  key = "Text.txt"
  source = "index.html"
  content_type = "text/html"
}
*/

provider "aws" {
  alias = "replica"
  region = "ap-south-1"
  
}

resource "aws_s3_bucket" "destination" {
    provider = aws.replica

  bucket = "new-year-bucker-113new31new"
  versioning {
    enabled = true
  }
  }

resource "aws_s3_bucket_versioning" "destination-versioning" {
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}
  


  #iam role for replication
resource "aws_iam_role" "replication-role" {
  name = "replication-role"

  assume_role_policy = jsonencode({
    Version="2012-10-17"
    Statement=[
      {
        Effect="Allow"
        Principal={
          Service="s3.amazonaws.com"
        }
        Action="sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "replication-policy" {
  name="replication-policy"
  role=aws_iam_role.replication-role.id
  policy= jsonencode({
      Version = "2012-10-17"
      Statement=[
        {
          Effect="Allow"
          Action=[
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectLegalHold",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectRetention"
          ]
          Resource="${aws_s3_bucket.source.arn}/*"
        },
        {
          Effect= "Allow"
          Action= ["s3:ReplicateObject","s3:ReplicateDelete",
          "s3:ReplicateTags"
          ]
          Resource="${aws_s3_bucket.destination.arn}/*"
        }
      ]
  })  
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.source.id
  role= aws_iam_role.replication-role.arn
  rule {
    id = "replication_rule"
    status = "Enabled"
    filter {
      prefix = ""
    }
    destination {
      bucket = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }

     delete_marker_replication {
      status = "Disabled"   # or "Enabled"
    }
  }  
}






/*

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

*/