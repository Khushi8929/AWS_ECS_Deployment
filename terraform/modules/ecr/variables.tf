# modules/ecr/variables.tf
variable "repo_name" {
  type        = string
  description = "ECR repo name"
  default = "ecr-kp"
}
