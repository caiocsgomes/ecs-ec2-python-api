resource "aws_route53_record" "alb_route" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.alb_endpoint
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
