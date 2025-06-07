variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "ecr_image_url" {
  description = "ECR image URL with tag"
  type        = string
}
