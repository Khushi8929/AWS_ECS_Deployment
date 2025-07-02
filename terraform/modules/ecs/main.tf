# modules/ecs/main.tf

resource "aws_ecs_cluster" "ecs-cluster-kp" {
  name = "${var.project_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "ecs-tskdf-kp" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = var.container_image
    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = var.log_group_name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "app"
      }
    }
  }])
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group_name
  retention_in_days = 7
}

resource "aws_ecs_service" "ecs-service-kp" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.ecs-cluster-kp.id
  task_definition = aws_ecs_task_definition.ecs-tskdf-kp.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    assign_public_ip = true
    security_groups = [var.security_group_id]
  }

  depends_on = [aws_ecs_task_definition.ecs-tskdf-kp]
}
