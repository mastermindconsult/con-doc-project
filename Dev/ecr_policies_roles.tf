# provision an AWS IAM role for ECR access

resource "aws_iam_role" "ecr_role" {
  name = "${var.project_name}-${var.environment}-ecr_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
        "Service": "ecr.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}


# provision an AWS IAM policy for ECR access

resource "aws_iam_policy" "policy" {
  name = "${var.project_name}-${var.environment}-ecr-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_policy_attachment" "attach" {
  name       = "${var.project_name}-${var.environment}-policy-role-attachment"
  roles      = ["${aws_iam_role.ecr_role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}


resource "aws_ecrpublic_repository_policy" "repo_policy" {
  repository_name = aws_ecrpublic_repository.ecr_repo.repository_name
  policy          = <<EOF
    {
    "Version": "2008-10-17",
    "Statement": [
        {
        "Sid": "Set the permission for ECR",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:CompleteLayerUpload",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetLifecyclePolicy",
            "ecr:InitiateLayerUpload",
            "ecr:PutImage",
            "ecr:UploadLayerPart"
            ]
        }
        ]
    }
    EOF
}