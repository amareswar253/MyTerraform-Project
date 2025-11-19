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

resource "aws_s3_bucket_server_side_encryption_configuration" "six" {
  bucket = aws_s3_bucket.one.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "arn:aws:kms:us-east-1:445567096684:key/522da118-434e-45c3-8ce7-91ffd5770f74"  # Here need to give your aws KMS key as are presented in your AWS Account 
    }
  }
}

terraform {
backend "s3" {
region = "us-east-1"
bucket = "amareswar.k8"
key = "prod/terraform.tfstate"
}
}
