# declare networking values

region                                              = "eu-west-2"
vpc_cidr                                            = "10.0.0.0/16"
instance_tenancy                                    = "default"
enable_dns_hostnames                                = true
enable_dns_support                                  = true
project_name                                        = "mastermind"
environment                                         = "dev"
public_subnet_cidrs                                 = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs                                = ["10.0.3.0/24", "10.0.4.0/24"]
private_subnet_id_1                                 = aws_subnet.private[0].id
private_subnet_id_2                                 = aws_subnet.private[1].id
map_public_ip_on_launch                             = true
map_private_ip_on_launch                            = false
enable_public_resource_name_dns_a_record_on_launch  = true
enable_private_resource_name_dns_a_record_on_launch = false


# RDS database attributes

name                  = "dbsng"
allocated_storage     = 20
max_allocated_storage = 100
engine                = "postgres"
engine_version        = "14.7"
instance_class        = "db.t3.micro"
db_name               = "dbdev"
parameter_group_name  = "default.postgres14"
skip_final_snapshot   = true
db_subnet_group_name  = "dbsng"

/*
# ECS and ECR attributes

repository_name                                     = 
ecs_tasks_execution_role_arn                        =
ecs_security_group_id                               =
container_image                                     = 
image_tag                                           = 
alb_target_group_arn                                =
service_namespace                                   =
max_capacity                                        =
min_capacity                                        =
policy_type                                         =
predefined_memory_metric_type                       =
predefined_cpu_metric_type                          =
cpu_target_value                                    =
memory_target_value                                 =


# web management attributes

root_domain_name                =
sub_domain_name                 =
domain_name                     =
alternative_name                =  
*/