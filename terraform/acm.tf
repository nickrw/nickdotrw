data "aws_acm_certificate" "nickrw_us_east_1" {
  provider = "aws.us_east_1"
  domain   = "nick.rw"
  statuses = ["ISSUED"]
}
