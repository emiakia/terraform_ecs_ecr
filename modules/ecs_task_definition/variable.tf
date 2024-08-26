variable "task_family" {
  description = "The family of the ECS task definition."
  type        = string
  default     = "nginxdemos-hello"
}

variable "task_cpu" {
  description = "The number of CPU units to reserve for the container."
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "The amount of memory (in MiB) to allocate for the container."
  type        = string
  default     = "3072"
}

variable "task_network_mode" {
  description = "The Docker networking mode to use for the containers in the task."
  type        = string
  default     = "awsvpc"
}

variable "task_requires_compatibilities" {
  description = "The launch type the task requires."
  type        = list(string)
  default     = ["FARGATE", "EC2"]
}

variable "task_execution_role_arn" {
  description = "The ARN of the IAM role that grants the ECS container agent permission to make calls to AWS APIs."
  type        = string
}

variable "task_task_role_arn" {
  description = "The ARN of the IAM role that the task can assume."
  type        = string
}

# variable "container_definitions" {
#   description = "A list of container definitions in JSON format."
#   type        = list(map(any))
# #   default     = [{
# #     name  = "nginxdemos-hello"
# #     image = "nginxdemos/hello"
# #     cpu   = 512
# #     memory = 3072
# #     essential = true
# #     portMappings = [{
# #       containerPort = 80
# #       hostPort      = 80
# #       protocol      = "tcp"
# #     }]
# #   }]
# }

variable "task_cdf_name" {
  description = "Name of the ECS task container definition"
  type        = string
  default     = "nginxdemos-hello"
}

variable "task_cdf_image" {
  description = "Docker image for the ECS task container"
  type        = string
  default     = "nginxdemos/hello"
}

variable "task_cdf_cpu" {
  description = "The amount of CPU to allocate for the ECS task container"
  type        = number
  default     = 512
}

variable "task_cdf_memory" {
  description = "The amount of memory (in MiB) to allocate for the ECS task container"
  type        = number
  default     = 3072
}

variable "task_cdf_essential" {
  description = "Whether the ECS task container is essential"
  type        = bool
  default     = true
}

variable "task_cdf_containerport" {
  description = "Port on the container to bind to"
  type        = number
  default     = 80
}

# variable "task_cdf_hostport" {
#   description = "Port on the host to bind to"
#   type        = number
#   default     = 80
# }

# variable "task_cdf_protocol" {
#   description = "Protocol for the container port mapping"
#   type        = string
#   default     = "tcp"
# }
