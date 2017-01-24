resource "aws_cloudfront_distribution" "nickrw_site" {
  origin {
    domain_name = "${aws_s3_bucket.nickrw_site.bucket}.s3.amazonaws.com"
    origin_id   = "myS3Origin"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.nickrw_site.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "nick.rw"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.nickrw_access_logs.bucket}.s3.amazonaws.com"
    prefix          = "cloudfront/nick.rw/"
  }

  aliases = ["nick.rw"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  custom_error_response {
    error_code = 404
    response_code = 404
    response_page_path = "/404.html"
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.nickrw_us_east_1.arn}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

}
