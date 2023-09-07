output "s3_bucket_id" {
    value       = aws_s3_bucket.s3_backend.id
    description = "S3 bucket ID"
}

output "dynamodb_table_id" {
    value       = aws_dynamodb_table.dynamodb_table.id
    description = "S3 bucket ID"
}