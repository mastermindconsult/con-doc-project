# security group outputs

output "rds_sg_id" {
  value       = aws_security_group.sg["RDS"].id
  description = "Terraform please provide RDS Database security group as soon as you APPLY"
}

output "dev_sg_id" {
  value       = aws_security_group.sg["Dev"].id
  description = "Terraform please provide Pre-production security group as soon as you APPLY"
}

output "prod_sg_id" {
  value       = aws_security_group.sg["Prod"].id
  description = "Terraform please provide Production security group as soon as you APPLY"
}

# image url
output "image_url" {
    value = aws_ecr_repository.ecr_repo.repository_url
}