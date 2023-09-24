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
  value       = aws_ecrpublic_repository.ecr_repo.repository_uri
  description = "Terraform please provide Image URL as soon as you APPLY"
}


# ecs tasks execution role output

output "ecs_tasks_execution_role_arn" {
  value = aws_iam_role.ecs_tasks_execution_role.arn
}


# ecs outputs

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}



# networking outputs

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public[0].id
}

output "public_subnet_id_2" {
  value = aws_subnet.public[1].id
}

output "private_subnet_id_1" {
  value = aws_subnet.private[0].id
}

output "private_subnet_id_2" {
  value = aws_subnet.private[1].id
}

output "project_name" {
  value = var.project_name
}

output "internet_gateway" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id_1" {
  value = aws_nat_gateway.ngw[0].id
}

output "nat_gateway_id_2" {
  value = aws_nat_gateway.ngw[1].id
}

output "region" {
  value = var.region
}