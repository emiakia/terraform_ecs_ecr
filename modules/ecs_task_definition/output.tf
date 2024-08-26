output "task_definition_arn" {
  description = "The ARN of the ECS task definition."
  value       = aws_ecs_task_definition.task_definition.arn
}

output "task_definition_id" {
  description = "The ID of the ECS task definition."
  value       = aws_ecs_task_definition.task_definition.id
}
