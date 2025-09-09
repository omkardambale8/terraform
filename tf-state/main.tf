terraform{
  backend "s3" {
    bucket = "my-terraform123-state-bucket-123456"
    key = "env/dev/terraform.tfstate"
    region="us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt=true  
  }

}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create S3 Bucket for Remote State
resource "aws_s3_bucket" "tf-state" {
    bucket = "my-terraform123-state-bucket-123456"
    versioning {
      enabled = true
    }

    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
}
  # Create DynamoDB Table for Locking

resource "aws_dynamodb_table" "tf-lock-table" {
  name = "tf-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
# NOTE: Add this block AFTER S3 + DynamoDB are created

terraform{
  backend "s3" {
    bucket = "my-terraform123-state-bucket-123456"
    key = "env/dev/terraform.tfstate"
    region="us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt=true  
  }

}