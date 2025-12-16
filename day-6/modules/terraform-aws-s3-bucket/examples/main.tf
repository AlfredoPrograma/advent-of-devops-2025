provider "aws" {}

module "aws_s3_bucket" {
  source                  = "../"
  name                    = "alfredoprograma-advent-day6"
  block_all_public_access = true
  enable_versioning       = true
  environment             = "development"
  tags = {
    Hello = "World"
  }
}

output "bucket_id" {
  value = module.aws_s3_bucket.bucket_id
}

output "bucket_arn" {
  value = module.aws_s3_bucket.bucket_arn
}
