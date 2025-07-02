# modules/ecr/outputs.tf
output "repository_url" {
  value = aws_ecr_repository.acr-kp.repository_url
}
