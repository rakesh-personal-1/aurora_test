#Create an S3 bucket
resource "aws_s3_bucket" "aws_s3_bucket_versioning" {
    bucket = "auroradev-terraform-state-backend"
    object_lock_enabled = true
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

# Configure server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse_config" {
  bucket = aws_s3_bucket.aws_s3_bucket_versioning.bucket
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#Create DynamoDB table
resource "aws_dynamodb_table" "terraform-lock" {
    name           = "terraform_state"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}

#Map S3 and DynamoDB as the backend

#terraform {
#  backend "s3" {
#    bucket         = "auroradev-terraform-state-backend"
#    key            = "terraform.tfstate"
#    region         = "us-east-1"
#    dynamodb_table = "terraform_state"
#  }
#}
