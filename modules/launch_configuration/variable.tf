variable "launch_config_name" {
  type        = string
  description = "Name of the launch configuration"
  default     = "ecs-launch-config"
}

variable "image_id" {
  type        = string
  description = "ID of the AMI to launch"
}

variable "instance_type" {
  type        = string
  description = "Type of instance to launch"
  default     = "t2.micro"
}

variable "security_group_id" {
  type        = string
  description = "ID of the security group"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "Name of the IAM instance profile"
}
