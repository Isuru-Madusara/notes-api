variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "notes-api"
}
