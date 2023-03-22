variable "project_name" {}
variable "alb_endpoint" {}
variable "hosted_zone" {}
variable "vpc_id" {}
variable "subnets_ids" {
  type = list(any)
}
variable "listener" {
  type = map(any)
  default = {
    port       = "443"
    protocol   = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}
