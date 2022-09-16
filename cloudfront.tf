# locals {
#   s3_origin_id = "myS3Origin"
# }

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucketforcodersonly.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.bucketforcodersonly.bucket


    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai-cloudfront.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"


 default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.bucketforcodersonly.bucket

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }



  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
       locations        = []
    }
  }

  tags = {
    Environment = "dev"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


#OAI for cloudront
resource "aws_cloudfront_origin_access_identity" "oai-cloudfront" {
  comment = "OAI for cloudront"

}

###################################
# S3 Bucket Policy
###################################
resource "aws_s3_bucket_policy" "read_bucket" {
  bucket = aws_s3_bucket.bucketforcodersonly.id
  policy = data.aws_iam_policy_document.read_bucket.json
}

###################################
# IAM Policy Document
###################################
data "aws_iam_policy_document" "read_bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucketforcodersonly.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai-cloudfront.iam_arn]
    }
  }
}
