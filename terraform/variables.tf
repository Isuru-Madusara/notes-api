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

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}
variable "github_repo" {
  description = "GitHub repository allowed to assume the deploy role (owner/name)"
  type        = string
  default     = "Isuru-Madusara/notes-api"
}
