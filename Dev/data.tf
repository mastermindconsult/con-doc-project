# create data block for AZs

data "aws_availability_zones" "available" {
  state = "available"
}


# get details about a route 53 hosted zone

data "aws_route53_zone" "route53_zone" {
  name         = var.domain_name
  private_zone = false
}


# get details about a AWS secrets manager

data "aws_secretsmanager_secret" "dbcreds" {
  name = "dbcreds"
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
  secret_id = data.aws_secretsmanager_secret.dbcreds.id
}