data "aws_route53_zone" "nick_dot_rw" {
  name         = "nick.rw."
  private_zone = false
}

resource "aws_route53_record" "nickrw_site" {
  zone_id = "${data.aws_route53_zone.nick_dot_rw.zone_id}"
  name    = ""
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.nickrw_site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.nickrw_site.hosted_zone_id}"
    evaluate_target_health = false
  }
}
