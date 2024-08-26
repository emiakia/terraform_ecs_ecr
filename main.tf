provider "aws" {
  region = var.aws_region
}

# VPC Data
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Import the security group module
module "security_group" {
  source                 = "./modules/security_group"
  sg_vpc_id              = data.aws_vpc.default.id
  sg_name                = var.sg_name
  sg_description         = var.sg_description
  sg_ingress_from_port   = var.sg_ingress_from_port
  sg_ingress_to_port     = var.sg_ingress_to_port
  sg_ingress_protocol    = var.sg_ingress_protocol
  sg_ingress_cidr_blocks = var.sg_ingress_cidr_blocks
  sg_egress_from_port    = var.sg_egress_from_port
  sg_egress_to_port      = var.sg_egress_to_port
  sg_egress_protocol     = var.sg_egress_protocol
  sg_egress_cidr_blocks  = var.sg_egress_cidr_blocks
}
# Security Group
# resource "aws_security_group" "ecs_sg" {
#   name        = "ecs_sg"
#   description = "Allow inbound access on port 80"
#   vpc_id      = data.aws_vpc.default.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# Import the ECS Cluster module
module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = var.ecs_cluster_name
}
# ECS Cluster
# resource "aws_ecs_cluster" "MyECSCluster" {
#   name = "MyECSCluster"  # Replace with variable if needed
# }

# Data Source for Amazon Linux 2 AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Import the Launch Configuration module
module "launch_configuration" {
  source                    = "./modules/launch_configuration"
  launch_config_name        = var.launch_config_name
  image_id                  = data.aws_ami.amazon_linux2.id
  instance_type             = var.instance_type
  security_group_id         = module.security_group.sg_id
  ecs_cluster_name          = module.ecs_cluster.cluster_name
  iam_instance_profile_name = module.iam_instance_profile.instance_profile_arn
}
# Launch Configuration for Auto Scaling Group
# resource "aws_launch_configuration" "ecs_launch_config" {
#   name          = "ecs-launch-config"
#   image_id      = data.aws_ami.amazon_linux2.id
#   instance_type = "t2.micro"  # Replace with variable if needed
#   security_groups = [
#     module.security_group.sg_id
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               echo ECS_CLUSTER=${module.ecs_cluster.cluster_name} >> /etc/ecs/ecs.config
#               EOF

#   iam_instance_profile = aws_iam_instance_profile.ecs_instance_role.name
# }

# Auto Scaling Group
module "autoscaling_group" {
  source                  = "./modules/autoscaling_group"
  desired_capacity        = var.asg_desired_capacity
  max_size                = var.asg_max_size
  min_size                = var.asg_min_size
  launch_configuration_id = module.launch_configuration.launch_configuration_id
  subnet_ids              = data.aws_subnets.default.ids
  tag_key                 = var.asg_tag_key
  tag_value               = var.asg_tag_value
}
# resource "aws_autoscaling_group" "ecs_asg" {
#   desired_capacity     = 0
#   max_size             = 3
#   min_size             = 0
#   launch_configuration = module.launch_configuration.launch_configuration_id
#   vpc_zone_identifier  = data.aws_subnets.default.ids

#   tag {
#     key                 = "Name"
#     value               = "ecs-instance"
#     propagate_at_launch = true
#   }
# }

# ECS Task Definition
module "ecs_task_definition" {
  source                        = "./modules/ecs_task_definition"
  task_family                   = var.task_family
  task_cpu                      = var.task_cpu
  task_memory                   = var.task_memory
  task_network_mode             = var.task_network_mode
  task_requires_compatibilities = var.task_requires_compatibilities
  task_execution_role_arn       = module.iam_role.iam_role_arn
  task_task_role_arn            = module.iam_role.iam_role_arn
  task_cdf_name                 = var.task_cdf_name
  task_cdf_image                = var.task_cdf_image
  task_cdf_cpu                  = var.task_cdf_cpu
  task_cdf_memory               = var.task_cdf_memory
  task_cdf_essential            = var.task_cdf_essential
  # task_cdf_containerport        = var.task_cdf_containerport
  # task_cdf_hostPort             = var.task_cdf_hostPort
  # task_cdf_protocol             = var.task_cdf_protocol
}
# resource "aws_ecs_task_definition" "nginxdemos_hello" {
#   family                   = "nginxdemos-hello"
#   cpu                      = "512"
#   memory                   = "3072"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE", "EC2"]
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
#   container_definitions    = jsonencode([{
#     name  = "nginxdemos-hello"
#     image = "nginxdemos/hello"
#     cpu   = 512
#     memory = 3072
#     essential = true
#     portMappings = [{
#       containerPort = 80
#       hostPort      = 80
#       protocol      = "tcp"
#     }]
#   }])
# }


# Import the ECS Service module
module "ecs_service" {
  source                        = "./modules/ecs_service"
  ecs_service_name              = var.ecs_service_name
  ecs_cluster_id                = module.ecs_cluster.cluster_id
  ecs_task_definition_arn       = module.ecs_task_definition.task_definition_arn
  ecs_desired_count             = var.ecs_desired_count
  ecs_launch_type               = var.ecs_launch_type
  ecs_platform_version          = var.ecs_platform_version
  subnet_ids                    = data.aws_subnets.default.ids
  security_group_ids            = [module.security_group.sg_id]
  ecs_assign_public_ip          = var.ecs_assign_public_ip
  load_balancer_target_group_arn = module.web_tg.tg_arn #aws_lb_target_group.tg_nginxdemos_hello.arn
  load_balancer_container_name  = var.load_balancer_container_name 
  load_balancer_container_port  = var.load_balancer_container_port 
  ecs_deployment_min_healthy_percent = var.ecs_deployment_min_healthy_percent
  ecs_deployment_max_percent         = var.ecs_deployment_max_percent
  dependency_resources          = [module.web_listener.web_listener_arn] #[aws_lb_listener.alb_listener.arn]
}
# ECS Service
# resource "aws_ecs_service" "nginxdemos_hello_service" {
#   name             = "nginxdemos-hello"
#   cluster          = module.ecs_cluster.cluster_id
#   task_definition  = module.ecs_task_definition.task_definition_arn
#   desired_count    = 1
#   launch_type      = "FARGATE"
#   platform_version = "LATEST"
#   network_configuration {
#     subnets          = data.aws_subnets.default.ids
#     security_groups  = [module.security_group.sg_id]
#     assign_public_ip = true
#   }
#   load_balancer {
#     target_group_arn = aws_lb_target_group.tg_nginxdemos_hello.arn
#     container_name   = "nginxdemos-hello"
#     container_port   = 80
#   }
#   deployment_minimum_healthy_percent = 50
#   deployment_maximum_percent         = 200

#   depends_on = [aws_lb_listener.alb_listener]
# }

# Application Load Balancer
module "alb" {
  source                         = "./modules/alb"
  alb_name                       = var.alb_name
  alb_internal                   = var.alb_internal
  alb_load_balancer_type         = var.alb_load_balancer_type
  alb_security_groups            = [module.security_group.sg_id]
  alb_subnets                    = data.aws_subnets.default.ids #var.alb_subnets
  alb_enable_deletion_protection = var.alb_enable_deletion_protection
  alb_tags                       = var.alb_tags
}

# resource "aws_lb" "alb" {
#   name               = "albForECS"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [module.security_group.sg_id]
#   subnets            = data.aws_subnets.default.ids
# }

# Load Balancer Listener
module "web_listener" {
  source                  = "./modules/lb_listener"
  lblst_load_balancer_arn = module.alb.alb_arn

  lblst_port     = var.lblst_port
  lblst_protocol = var.lblst_protocol

  lblst_default_action_type             = var.lblst_default_action_type
  lblst_default_action_target_group_arn = module.web_tg.tg_arn
}

# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = module.alb.alb_arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg_nginxdemos_hello.arn
#   }
# }

# Load Balancer Target Group
module "web_tg" {
  source        = "./modules/lb_target_group"
  lbtg_name     = var.lbtg_name
  lbtg_port     = var.lbtg_port
  lbtg_protocol = var.lbtg_protocol
  lbtg_vpc_id   = data.aws_vpc.default.id
  lbtg_target_type = var.lbtg_target_type
  
  lbtg_health_check_path     = var.lbtg_health_check_path
  lbtg_health_check_protocol = var.lbtg_health_check_protocol
  lbtg_health_check_matcher  = var.lbtg_health_check_matcher
  lbtg_health_check_interval = var.lbtg_health_check_interval
  lbtg_health_check_timeout  = var.lbtg_health_check_timeout
  lbtg_healthy_threshold     = var.lbtg_healthy_threshold
  lbtg_unhealthy_threshold   = var.lbtg_unhealthy_threshold

  lbtg_tags = var.lbtg_tags
}

# resource "aws_lb_target_group" "tg_nginxdemos_hello" {
#   name     = "tg-nginxdemos-hello"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = data.aws_vpc.default.id

#   target_type = "ip" # Change target type to 'ip'

#   health_check {
#     protocol = "HTTP"
#     path     = "/"
#     interval = 300
#   }
# }

# IAM Roles for ECS
module "iam_role" {
  source                = "./modules/iam_role"
  iam_role_name         = var.iam_role_name
  assume_role_service   = var.assume_role_service
  policy_version        = var.policy_version
  policy_action         = var.policy_action
  policy_effect         = var.policy_effect
}
# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs_task_execution_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       }
#     }]
#   })
# }

# Import IAM Role Policy Attachment module
module "iam_role_policy_attachment" {
  source      = "./modules/iam_role_policy_attachment"
  policy_arn  = var.policy_arn
  role_name   = module.iam_role.iam_role_name
}

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#   role       = module.iam_role.iam_role_name
# }

# Import IAM Instance Profile module
module "iam_instance_profile" {
  source                = "./modules/iam_instance_profile"
  instance_profile_name = var.instance_profile_name
  role_name             = module.iam_role.iam_role_name
}
# resource "aws_iam_instance_profile" "ecs_instance_role" {
#   name = "ecs-instance-role"
#   role = aws_iam_role.ecs_instance_role.name
# }

#
module "iam_ecs_instance_role" {
  source                = "./modules/iam_role"
  iam_role_name         = var.iam_ecs_instance_role_name
  assume_role_service   = var.assume_role_service
  policy_version        = var.policy_version
  policy_action         = var.policy_action
  policy_effect         = var.policy_effect
}

# resource "aws_iam_role" "ecs_instance_role" {
#   name = "ecs-instance-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#   })
# }

module "iam_role_instance_policy_attachment" {
  source      = "./modules/iam_role_policy_attachment"
  policy_arn  = var.instance_policy_arn
  role_name   = module.iam_ecs_instance_role.iam_role_name
}

# resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
#   role       = module.iam_ecs_instance_role.iam_role_name  #aws_iam_role.ecs_instance_role.name
# }