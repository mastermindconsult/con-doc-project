# provision an AWS ECR repository

resource "aws_ecrpublic_repository" "ecr_repo" {
  repository_name = "${var.project_name}-${var.environment}-ecr_repo"
  force_destroy   = true
  lifecycle {
    ignore_changes = [tags]
  }
}