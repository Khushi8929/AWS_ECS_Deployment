# modules/ecs/outputs.tf

output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs-cluster-kp.id
}

output "ecs_service_name" {
  value = aws_ecs_service.ecs-service-kp.name
}
