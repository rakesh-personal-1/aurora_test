#Create an S3 bucket
resource "aws_s3_bucket" "bucket" {
    bucket = "auroradev-terraform-state-backend"
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
    object_lock_configuration {
        object_lock_enabled = "Enabled"
    }
    tags = {
        Name = "S3 Remote Terraform State Store"
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
