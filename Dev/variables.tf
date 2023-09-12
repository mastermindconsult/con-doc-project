variable "region" {}
#testing merge and pull
#variable "" {}
variable "environment" {}
variable "project_name" {}
#dbsubnetgroup attributes
variable "name" {}
#rds database attributes
variable "allocated_storage" {}
variable "max_allocated_storage" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_name" {}
variable "parameter_group_name" {}
variable "skip_final_snapshot" {}
variable "db_subnet_group_name" {}
variable "repository_name" {}
variable "image_tag" {}
variable "root_domain_name" {}
variable "sub_domain_name" {}


#networking variables
variable "region" {}
variable "vpc_cidr" {}
variable "instance_tenancy" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}
variable "project_name" {}
variable "environment" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "map_public_ip_on_launch" {}
variable "map_private_ip_on_launch" {}
variable "enable_public_resource_name_dns_a_record_on_launch" {}
variable "enable_private_resource_name_dns_a_record_on_launch" {}