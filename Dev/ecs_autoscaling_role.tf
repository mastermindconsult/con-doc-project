# ECS autoscaling IAM role 

resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "${var.project_name}-ECS-AutoscaleRole-${var.environment}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    Name        = "${var.project_name}-ECS_AutoscaleRole-${var.environment}"
    Environment = var.environment
  }
}


# ecs autoscaling IAM role policy attachment 

resource "aws_iam_role_policy_attachment" "ecs_autoscale_role_policy_attachment" {
  role       = aws_iam_role.ecs_autoscale_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}