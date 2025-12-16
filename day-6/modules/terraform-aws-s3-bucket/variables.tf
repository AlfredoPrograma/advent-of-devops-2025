variable "name" {
  description = "Name of the S3 Bucket"
  type        = string
}

variable "environment" {
  description = "Running environment"
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production"
  }
}

variable "tags" {
  description = "Map of custom tags for bucket"
  type        = map(string)
  nullable    = true
  default     = null
}

variable "enable_versioning" {
  description = "Enables bucket objects versioning"
  type        = bool
  default     = false
}

variable "block_all_public_access" {
  description = "Blocks ALL public access"
  type        = bool
  default     = true
}

variable "policy" {
  description = "Custom bucket policy"
  type        = string
  nullable    = true
  default     = null
}
