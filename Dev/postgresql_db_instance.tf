#0. Create RDS

resource "aws_db_instance" "database" {
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_username"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_password"]
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnetgroup.name}"

}
