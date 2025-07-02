# modules/vpc/variables.tf
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet"
}

variable "availability_zone" {
  type        = string
  description = "AWS AZ to deploy subnet"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}
