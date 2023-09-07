variable "project_name" {
    default = "Mastermind_CDD"
}

#dynamo db
variable "dynamo_db_name" {
    default = "mastermind-state-lock"
}
variable "write_capacity" {
    default = "5"
}
variable "read_capacity" {
    default = "5"
}
