provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "ch-greeting-service-backend" {
  bucket = "ch-greeting-service-bucket"
  tags = {
    Name        = "ch-greeting-service-bucket",
    Environment = "production"
  }
}


resource "aws_s3_bucket_public_access_block" "googleplay-dumper-access-block" {
  bucket = aws_s3_bucket.ch-greeting-service-backend.id

  block_public_acls   = true
  block_public_policy = true
}
