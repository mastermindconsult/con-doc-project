#Create dynamo db table
resource "aws_dynamodb_table" "dynamodb_table" {
    name = var.dynamo_db_name
    billing_mode = "PROVISIONED"
    read_capacity = var.read_capacity
    write_capacity = var.write_capacity
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
    
    tags = {
        Name = "${var.project_name}-dbTable"
    }
}