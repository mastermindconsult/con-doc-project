# create an s3 bucket 
resource "aws_s3_bucket" "s3_backend" {
  bucket = "mastermind-terraform-remote-state"
  force_destroy = true

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "s3_bucket_version" {
  bucket = "mastermind-terraform-remote-state"
  versioning_configuration {
    status = "Enabled"
  } 
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption_config" {
  bucket = "mastermind-terraform-remote-state"
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  
}

/*resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project_name_d}-bucket"

  lifecycle {
    create_before_destroy = false
  }
}*/

