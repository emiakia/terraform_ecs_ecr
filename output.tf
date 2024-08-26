output "sg_id" {
  value = module.security_group.sg_id
}

# Output ECS Cluster information
output "ecs_cluster_name" {
  description = "The ID of the ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs_cluster.cluster_id
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.ecs_cluster.cluster_arn
}

# Output launch configuration ID
output "launch_configuration_id" {
  value = module.launch_configuration.launch_configuration_id
}

# 
output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group"
  value       = module.autoscaling_group.autoscaling_group_id
}

# Output ECS Task Definition information
output "ecs_task_definition_arn" {
  value = module.ecs_task_definition.task_definition_arn
}

output "ecs_task_definition_id" {
  value = module.ecs_task_definition.task_definition_id
}

output "ecs_service_id" {
  description = "The ID of the ECS service."
  value       = module.ecs_service.ecs_service_id
}

output "ecs_service_name" {
  description = "The name of the ECS service."
  value       = module.ecs_service.ecs_service_name
}

#alb
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}
output "alb_arn" {
  description = "The ARN of the Load Balancer"
  value       = module.alb.alb_arn
}


#alb listener
output "web_listener_arn" {
  description = "The ALB Listener arn"
  value       = module.web_listener.web_listener_arn
}

output "iam_role_id" {
  description = "The ID of the IAM role."
  value       = module.iam_role.iam_role_id
}

output "iam_role_name" {
  description = "The name of the IAM role."
  value       = module.iam_role.iam_role_name
}

output "iam_role_arn" {
  description = "The ARN of the IAM role."
  value       = module.iam_role.iam_role_arn
}


output "role_policy_attachment_id" {
  description = "The ID of the IAM role policy attachment."
  value       = module.iam_role_policy_attachment.role_policy_attachment_id
}

output "instance_profile_id" {
  description = "The ID of the IAM instance profile."
  value       = module.iam_instance_profile.instance_profile_id
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile."
  value       = module.iam_instance_profile.instance_profile_name
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile."
  value       = module.iam_instance_profile.instance_profile_arn
}

output "iam_ecs_instance_role" {
  description = "The name of the IAM role."
  value       = module.iam_ecs_instance_role.iam_role_name
}

# output "role_policy_attachment_id" {
#   description = "The ID of the IAM role policy attachment."
#   value       = module.iam_role_policy_attachment.role_policy_attachment_id
# }
