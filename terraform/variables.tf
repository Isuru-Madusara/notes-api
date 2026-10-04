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

variable "github_repo_sub" {
  description = "Repo as it appears in the GitHub OIDC subject claim (name@id form)"
  type        = string
  default     = "Isuru-Madusara@157903563/notes-api@1404548243"
}
