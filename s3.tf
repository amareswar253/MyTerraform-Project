resource "aws_s3_bucket" "one" {
  bucket = "amareswar.k8"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "four" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}
resource "aws_s3_bucket_public_access_block" "five" {
  bucket = aws_s3_bucket.one.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

terraform {
backend "s3" {
region = "us-east-1"
bucket = "amareswar.k8"
key = "prod/terraform.tfstate"
}
}
