resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener["port"]
  protocol          = var.listener["protocol"]
  ssl_policy        = var.listener["ssl_policy"]
  certificate_arn   = aws_acm_certificate_validation.cert_validation.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "route not implemented"
      status_code  = "501"
    }
  }
}
