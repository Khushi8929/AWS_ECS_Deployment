# modules/ecs/variables.tf

variable "project_name" {
  type = string
}

variable "cpu" {
  type    = string
  default = "256"
}

variable "memory" {
  type    = string
  default = "512"
}

variable "execution_role_arn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "log_group_name" {
  type = string
}

variable "region" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
