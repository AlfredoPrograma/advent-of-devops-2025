resource "aws_s3_bucket" "bucket" {
  bucket = var.name

  tags = merge(
    var.tags,
    {
      Name        = var.name,
      Environment = var.environment,
      ManagedBy   = "Terraform"
    }
  )
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_all_public_access
  block_public_policy     = var.block_all_public_access
  ignore_public_acls      = var.block_all_public_access
  restrict_public_buckets = var.block_all_public_access
}

resource "aws_s3_bucket_policy" "bucket" {
  count  = var.policy != null ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = var.policy
}
