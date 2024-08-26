resource "aws_ecs_service" "ecs_service" {
  name             = var.ecs_service_name
  cluster          = var.ecs_cluster_id
  task_definition  = var.ecs_task_definition_arn
  desired_count    = var.ecs_desired_count
  launch_type      = var.ecs_launch_type
  platform_version = var.ecs_platform_version

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.ecs_assign_public_ip
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.load_balancer_container_name
    container_port   = var.load_balancer_container_port
  }

  deployment_minimum_healthy_percent = var.ecs_deployment_min_healthy_percent
  deployment_maximum_percent         = var.ecs_deployment_max_percent

  depends_on = [var.dependency_resources]
}
