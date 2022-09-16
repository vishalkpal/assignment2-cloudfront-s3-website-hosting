provider "aws" {
    region = var.region
}

resource "aws_s3_bucket" "bucketforcodersonly" {

  bucket = "bucketforcodersonly"
  tags = {
    Name        = "bucketforcodersonly"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.bucketforcodersonly.id

  block_public_acls       = true
  block_public_policy     = true 
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "acl1" {
  bucket = aws_s3_bucket.bucketforcodersonly.id
  acl    = "private"
}

# Upload an object
resource "aws_s3_bucket_object" "object" {

  bucket = aws_s3_bucket.bucketforcodersonly.id
  key    = "index.html"
  acl    = "private"  # or can be "public-read"
  source = "./index.html"
  etag = filemd5("./index.html")
}
