#security group variables
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

# Security Group Variables
variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "ecs_sg"
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow inbound access on port 80"
}

variable "sg_ingress_from_port" {
  description = "Starting port for ingress rule"
  type        = number
  default     = 80
}

variable "sg_ingress_to_port" {
  description = "Ending port for ingress rule"
  type        = number
  default     = 80
}

variable "sg_ingress_protocol" {
  description = "Protocol for ingress rule"
  type        = string
  default     = "tcp"
}

variable "sg_ingress_cidr_blocks" {
  description = "CIDR blocks for ingress rule"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_from_port" {
  description = "Starting port for egress rule"
  type        = number
  default     = 0
}

variable "sg_egress_to_port" {
  description = "Ending port for egress rule"
  type        = number
  default     = 0
}

variable "sg_egress_protocol" {
  description = "Protocol for egress rule"
  type        = string
  default     = "-1"
}

variable "sg_egress_cidr_blocks" {
  description = "CIDR blocks for egress rule"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


###############################
# ecs_cluster variables

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "MyECSCluster"
}


################################
# Launch Configuration Variables
variable "launch_config_name" {
  description = "Name of the launch configuration"
  type        = string
  default     = "ecs-launch-config"
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
  default     = "t2.micro"
}
#############################
# Auto Scaling Group Variables
variable "asg_desired_capacity" {
  description = "The number of instances to start with."
  type        = number
  default     = 0
}

variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling group."
  type        = number
  default     = 3
}

variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling group."
  type        = number
  default     = 0
}

variable "asg_tag_key" {
  description = "The key of the tag to apply to instances."
  type        = string
  default     = "Name"
}

variable "asg_tag_value" {
  description = "The value of the tag to apply to instances."
  type        = string
  default     = "ecs-instance"
}
################################################################
#
# ECS Task Definition Variables
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

# variable "task_container_definitions" {
#   description = "A list of container definitions in JSON format."
#   type        = list(map(any))
#   # default     = [{
#   #   name  = "nginxdemos-hello"
#   #   image = "nginxdemos/hello"
#   #   cpu   = 512
#   #   memory = 3072
#   #   essential = true
#   #   portMappings = [{
#   #     containerPort = 80
#   #     hostPort      = 80
#   #     protocol      = "tcp"
#   #   }]
#   # }]
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

# variable "task_cdf_containerport" {
#   description = "Port on the container to bind to"
#   type        = number
#   default     = 80
# }

# variable "task_cdf_hostPort" {
#   description = "Port on the host to bind to"
#   type        = number
#   default     = 80
# }

# variable "task_cdf_protocol" {
#   description = "Protocol for the container port mapping"
#   type        = string
#   default     = "tcp"
# }

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
  default     = "nginxdemos-hello"
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

variable "ecs_assign_public_ip" {
  description = "Whether to assign a public IP address to the service."
  type        = bool
  default     = true
}

# variable "load_balancer_target_group_arn" {
#   description = "The ARN of the target group for the load balancer."
#   type        = string
# }

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


# #################################################
# #Variable of Application Load Balancer
# variable "alb_name" {}
# variable "alb_internal" {}
# variable "alb_load_balancer_type" {}
# variable "alb_subnets" {
#   type = list(string)
# }
# variable "alb_enable_deletion_protection" {}
# variable "alb_tags" {}
# ####################################################
# #Application Load balancer Variables 
# alb_name                       = "web-lb"
# alb_internal                   = false
# alb_load_balancer_type         = "application"
# alb_enable_deletion_protection = false
# alb_subnets                    = ["subnet-0a21b416cfd5ab2a3", "subnet-093f0311edbfe83fb", "subnet-04f0df809d5307602"]
# alb_tags = {
#   "Pupose" = "Test By Terraform For ALB"
# }

####################################################
# Application Load Balancer Variables

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "web-lb"
}

variable "alb_internal" {
  description = "Whether the Application Load Balancer is internal or external"
  type        = bool
  default     = false
}

variable "alb_load_balancer_type" {
  description = "The type of the Application Load Balancer"
  type        = string
  default     = "application"
}

# variable "alb_subnets" {
#   description = "List of subnets for the Application Load Balancer"
#   type        = list(string)
#   default     = [
#     "subnet-0a21b416cfd5ab2a3",
#     "subnet-093f0311edbfe83fb",
#     "subnet-04f0df809d5307602"
#   ]
# }

variable "alb_enable_deletion_protection" {
  description = "Whether deletion protection is enabled for the Application Load Balancer"
  type        = bool
  default     = false
}

variable "alb_tags" {
  description = "Tags to assign to the Application Load Balancer"
  type        = map(string)
  default     = {
    "Purpose" = "Test By Terraform For ALB"
  }
}

#Load balancer Listener variables
variable "lblst_port" {
  description = "The port on which the Load Balancer Listener will listen"
  type        = number
  default     = 80
}

variable "lblst_protocol" {
  description = "The protocol for the Load Balancer Listener"
  type        = string
  default     = "HTTP"
}

variable "lblst_default_action_type" {
  description = "The type of the default action for the Load Balancer Listener"
  type        = string
  default     = "forward"
}

variable "lblst_default_action_target_group_arn" {
  description = "The ARN of the target group for the default action of the Load Balancer Listener"
  type        = string
  default     = ""  # Set a default value if needed, otherwise keep it empty
}


# #Application Load Balancer Target Group
# variable "lbtg_name" {}
# variable "lbtg_port" {}
# variable "lbtg_protocol" {}
# # variable "lbtg_vpc_id" {}
# variable "lbtg_tags" {}
# #health_check
# variable "lbtg_health_check_path" {}
# variable "lbtg_health_check_protocol" {}
# variable "lbtg_health_check_matcher" {}
# variable "lbtg_health_check_interval" {}
# variable "lbtg_health_check_timeout" {}
# variable "lbtg_healthy_threshold" {}
# variable "lbtg_unhealthy_threshold" {}
# #Application Load Balancer Target Group
# lbtg_name     = "web-tg"
# lbtg_port     = 80
# lbtg_protocol = "HTTP"
# lbtg_tags = {
#   "Pupose" = "Test By Terraform For ALB"
# }
# lbtg_health_check_path     = "/"
# lbtg_health_check_protocol = "HTTP"
# lbtg_health_check_matcher  = "200"
# lbtg_health_check_interval = 30
# lbtg_health_check_timeout  = 5
# lbtg_healthy_threshold     = 3
# lbtg_unhealthy_threshold   = 2

# Application Load Balancer Target Group Variables
variable "lbtg_name" {
  description = "The name of the Target Group"
  type        = string
  default     = "web-tg"
}

variable "lbtg_port" {
  description = "The port on which the Target Group receives traffic"
  type        = number
  default     = 80
}

variable "lbtg_protocol" {
  description = "The protocol for the Target Group"
  type        = string
  default     = "HTTP"
}

variable "lbtg_vpc_id" {
  description = "The VPC ID where the Target Group is deployed"
  type        = string
  default     = ""  # Set a default value if needed, otherwise keep it empty
}
variable "lbtg_target_type" {
  description = "Target Type"
  type        = string
  default     = "ip" 
}

variable "lbtg_tags" {
  description = "Tags to assign to the Target Group"
  type        = map(string)
  default     = {
    "Purpose" = "Test By Terraform For ALB"
  }
}

# Health Check Variables

variable "lbtg_health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "lbtg_health_check_protocol" {
  description = "The protocol used for the health check"
  type        = string
  default     = "HTTP"
}

variable "lbtg_health_check_matcher" {
  description = "The expected HTTP response codes for a successful health check"
  type        = string
  default     = "200"
}

variable "lbtg_health_check_interval" {
  description = "The interval, in seconds, between health checks"
  type        = number
  default     = 30
}

variable "lbtg_health_check_timeout" {
  description = "The amount of time, in seconds, to wait when receiving a response from a health check"
  type        = number
  default     = 5
}

variable "lbtg_healthy_threshold" {
  description = "The number of consecutive health checks successes required to consider an unhealthy target healthy"
  type        = number
  default     = 3
}

variable "lbtg_unhealthy_threshold" {
  description = "The number of consecutive health checks failures required to consider a healthy target unhealthy"
  type        = number
  default     = 2
}


variable "iam_role_name" {
  description = "The name of the IAM role."
  type        = string
  default     = "ecs_task_execution_role"
}

variable "assume_role_service" {
  description = "The service that assumes the IAM role."
  type        = string
  default     = "ecs-tasks.amazonaws.com"
}

variable "policy_version" {
  description = "The version of the policy."
  type        = string
  default     = "2012-10-17"
}

variable "policy_action" {
  description = "The action allowed by the policy."
  type        = string
  default     = "sts:AssumeRole"
}

variable "policy_effect" {
  description = "The effect of the policy."
  type        = string
  default     = "Allow"
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile."
  type        = string
  default     = "ecs-instance-role"
}

variable "iam_ecs_instance_role_name" {
  description = "The name of the IAM role."
  type        = string
  default     = "ecs_instance_role"
}


variable "instance_policy_arn" {
  description = "The ARN of the Instance policy to attach to the role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
