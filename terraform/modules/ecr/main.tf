# modules/ecr/main.tf
resource "aws_ecr_repository" "acr-kp" {
  name = var.repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.repo_name
  }
}
