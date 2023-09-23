# create a listener on port 80 with forward action

resource "aws_lb_listener" "alb-http-listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}
