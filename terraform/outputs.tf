output "ecr_repository_url" {
  description = "URL used to push and pull the Docker image"
  value       = aws_ecr_repository.notes_api.repository_url
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "instance_public_ip" {
  description = "Public IP of the server"
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "URL where the app will be reachable"
  value       = "http://${aws_instance.app.public_ip}"
}
output "github_actions_role_arn" {
  description = "Role ARN used by GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}

output "tf_plan_role_arn" {
  value = aws_iam_role.tf_plan.arn
}

output "tf_apply_role_arn" {
  value = aws_iam_role.tf_apply.arn
}
