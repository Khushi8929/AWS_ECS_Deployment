output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}
