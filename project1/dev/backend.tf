resource "aws_s3_bucket" "default" {
  bucket        = "aurora-terraform-state-backend"
  force_destroy = true

}

resource "aws_s3_bucket_versioning" "default" {

  bucket = "aurora-terraform-state-backend"

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {

  bucket = "aurora-terraform-state-backend"

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "with_server_side_encryption" {
  name                        = "terraform_state"
  read_capacity               = 5
  write_capacity              = 5
  deletion_protection_enabled = false

  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  hash_key = "LockID"

  server_side_encryption { #tfsec:ignore:aws-dynamodb-table-customer-key
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

}

terraform {
  backend "s3" {
    bucket         = "aurora-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}
