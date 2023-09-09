# create an iam role for ecs task
resource "aws_iam_role" "ecs_task_role" {
    name = "${var.environment}-ecs-task-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
EOF
}

# create iam policy document
resource "aws_iam_policy" "ecs_task_execution_policy" {
    name = "${var.environment}-EcsTaskExecutionRole"

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Action   = [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
                ]
        Effect   = "Allow"
        Resource = "*"
        },
    ]
    })
}

# attach ecs task execution policy to the iam role
resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
    role       = aws_iam_role.ecs_task_role.name
    policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}