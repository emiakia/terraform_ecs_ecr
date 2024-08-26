variable "desired_capacity" {
  type        = number
  description = "The number of instances to start with."
  default     = 0
}

variable "max_size" {
  type        = number
  description = "The maximum size of the Auto Scaling group."
  default     = 3
}

variable "min_size" {
  type        = number
  description = "The minimum size of the Auto Scaling group."
  default     = 0
}

variable "launch_configuration_id" {
  type        = string
  description = "The ID of the launch configuration."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the Auto Scaling group."
}

variable "tag_key" {
  type        = string
  description = "The key of the tag to apply to instances."
  default     = "Name"
}

variable "tag_value" {
  type        = string
  description = "The value of the tag to apply to instances."
  default     = "ecs-instance"
}
