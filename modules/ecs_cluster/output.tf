output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.arn
}

output "cluster_name" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.name
}