resource "aws_security_group" "alb_security_group" {
  description = "security group for the alb"
  name        = format("%s-alb-sg", var.project_name)
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-alb-sg", var.project_name)
  }
}
