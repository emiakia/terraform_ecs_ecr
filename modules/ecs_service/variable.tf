variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
  default     = "nginxdemos-hello"
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition."
  type        = string
}

variable "ecs_desired_count" {
  description = "The desired number of instances of the task definition to run."
  type        = number
  default     = 1
}

variable "ecs_launch_type" {
  description = "The launch type on which to run your service."
  type        = string
  default     = "FARGATE"
}

variable "ecs_platform_version" {
  description = "The platform version on which to run your service."
  type        = string
  default     = "LATEST"
}

variable "subnet_ids" {
  description = "The subnets in which the ECS service should run."
  type        = list(string)
}

variable "security_group_ids" {
  description = "The security groups to associate with the ECS service."
  type        = list(string)
}

variable "ecs_assign_public_ip" {
  description = "Whether to assign a public IP address to the service."
  type        = bool
  default     = true
}

variable "load_balancer_target_group_arn" {
  description = "The ARN of the target group for the load balancer."
  type        = string
}

variable "load_balancer_container_name" {
  description = "The name of the container to associate with the load balancer."
  type        = string
  default     = "nginxdemos-hello"
}

variable "load_balancer_container_port" {
  description = "The port on the container to associate with the load balancer."
  type        = number
  default     = 80
}

variable "ecs_deployment_min_healthy_percent" {
  description = "The lower bound on the number of running tasks during a deployment."
  type        = number
  default     = 50
}

variable "ecs_deployment_max_percent" {
  description = "The upper bound on the number of running tasks during a deployment."
  type        = number
  default     = 200
}

variable "dependency_resources" {
  description = "Resources that the ECS service depends on."
  type        = list(string)
#   default     = []
}
