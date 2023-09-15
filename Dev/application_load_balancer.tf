# create ECS application load balancer
resource "aws_lb" "load-balancer" {
  name               = "${var.project_name}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg.id}"]
  subnets            = [aws_subnet.public[0].id, aws_subnet.[1].id]
  enable_deletion_protection = false

  tags   = {
    Name = "${var.project_name}-load-balancer"
  }
}