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


# ECR outputs

output "image_uri" {
  value       = aws_ecrpublic_repository.ecr_repo.repository_uri
  description = "Terraform please provide Image URL as soon as you APPLY"
}

output "repository_name" {
  value       = aws_ecrpublic_repository.ecr_repo.id
  description = "Terraform please provide ECR repo name as soon as you APPLY"
}


# ECS tasks execution role output

output "ecs_tasks_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "Terraform please provide Task Execution Role ARN as soon as you APPLY"
}


# ECS outputs

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.ecs_cluster.name
  description = "Terraform please provide ECS Cluster Name as soon as you APPLY"
}

output "ecs_service_name" {
  value       = aws_ecs_service.ecs_service.name
  description = "Terraform please provide ECS Service Name as soon as you APPLY"
}


# networking outputs

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "Terraform please provide VPC ID as soon as you APPLY"

}

output "public_subnet_id_1" {
  value       = aws_subnet.public[0].id
  description = "Terraform please provide Public Subnet ID 1 as soon as you APPLY"
}

output "public_subnet_id_2" {
  value       = aws_subnet.public[1].id
  description = "Terraform please provide Public Subnet ID 2 as soon as you APPLY"

}

output "private_subnet_id_1" {
  value       = aws_subnet.private[0].id
  description = "Terraform please provide Private Subnet ID 1 as soon as you APPLY"
}

output "private_subnet_id_2" {
  value       = aws_subnet.private[1].id
  description = "Terraform please provide Private Subnet ID 2 as soon as you APPLY"
}

output "project_name" {
  value       = var.project_name
  description = "Terraform please provide Project Name as soon as you APPLY"
}

output "internet_gateway" {
  value       = aws_internet_gateway.igw.id
  description = "Terraform please provide IGW ID as soon as you APPLY"
}

output "nat_gateway_id_1" {
  value       = aws_nat_gateway.ngw[0].id
  description = "Terraform please provide NGW 1 ID as soon as you APPLY"
}

output "nat_gateway_id_2" {
  value       = aws_nat_gateway.ngw[1].id
  description = "Terraform please provide NGW 2 ID as soon as you APPLY"
}