resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_family
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  network_mode             = var.task_network_mode
  requires_compatibilities = var.task_requires_compatibilities
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_task_role_arn
  #   container_definitions    = jsonencode(var.container_definitions)
  container_definitions = jsonencode([{
    name      = var.task_cdf_name
    image     = var.task_cdf_image
    cpu       = var.task_cdf_cpu
    memory    = var.task_cdf_memory
    essential = var.task_cdf_essential
    portMappings = [{
      containerPort = 80 #var.task_cdf_containerPort
      hostPort      = 80 #var.task_cdf_hostPort
      protocol      = "tcp" #var.task_cdf_protocol
    }]
  }])



}
