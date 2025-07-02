terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source             = "./modules/vpc"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "Allow inbound traffic to ECS containers"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = "${var.project_name}-repo"
}

module "ecs" {
  source            = "./modules/ecs"
  project_name      = var.project_name
  cpu               = "256"
  memory            = "512"
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  container_image   = "${module.ecr.repository_url}:latest"
  container_port    = 3000
  log_group_name    = "/ecs/${var.project_name}"
  region            = var.region
  desired_count     = 1
  subnets           = [module.vpc.public_subnet_id]
  security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_security_group" "ecs_securitygrp" {
  name        = "${var.project_name}-ecs-securitygrp"
  description = "Allow inbound traffic to ECS containers"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm if ECS CPU > 70%"
  dimensions = {
    ClusterName = module.ecs.ecs_cluster_id
    ServiceName = module.ecs.ecs_service_name
  }
  alarm_actions = [] # Add SNS or action if needed
}
