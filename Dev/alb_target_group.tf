# create ECS ALB target group with HTTP protocol (port 80)

resource "aws_lb_target_group" "lb-target-group" {
  name        = "${var.project_name}-lb-target-group"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id


  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 5
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }
}