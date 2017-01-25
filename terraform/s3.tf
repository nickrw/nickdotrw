variable "nickrw_site_bucket" {
  default = "nickrw-site"
}

resource "aws_s3_bucket" "nickrw_access_logs" {
  bucket = "nickrw-access-logs"
  acl    = "private"
}

resource "aws_s3_bucket" "nickrw_site" {
  bucket = "${var.nickrw_site_bucket}"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.s3_nickrw_site.json}"
}

resource "aws_cloudfront_origin_access_identity" "nickrw_site" {}

data "aws_iam_policy_document" "s3_nickrw_site" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.nickrw_site_bucket}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.nickrw_site.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.nickrw_site_bucket}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.nickrw_site.iam_arn}"]
    }
  }
}
