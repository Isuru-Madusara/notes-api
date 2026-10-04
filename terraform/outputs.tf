output "ecr_repository_url" {
  description = "URL used to push and pull the Docker image"
  value       = aws_ecr_repository.notes_api.repository_url
}
