resource "aws_ecr_repository" "ecr_repo" {
    name         = "${var.project_name}-${var.environment}-ecr_repo"
    force_delete = true

    image_scanning_configuration {
    scan_on_push = true
    }
    encryption_configuration {
    encryption_type = "KMS"
    }
}




