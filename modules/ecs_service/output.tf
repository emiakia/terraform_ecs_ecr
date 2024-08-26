output "ecs_service_id" {
  description = "The ID of the ECS service."
  value       = aws_ecs_service.ecs_service.id
}

output "ecs_service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.ecs_service.name
}
