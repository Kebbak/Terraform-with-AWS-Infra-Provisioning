# s3 bucket for terraform state files
resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name
  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}
