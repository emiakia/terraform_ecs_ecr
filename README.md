# Modular ECS Cluster with Fargate and EC2 Instances

## Overview

This Terraform configuration is designed to set up an Amazon ECS (Elastic Container Service) environment using a fully modular structure. It supports both Fargate and EC2 launch types, ensuring flexibility and scalability. The configuration includes:

- **ECS Cluster**: Created using a modular approach for easy management.
- **Auto Scaling Group**: Manages EC2 instances with customizable settings.
- **EC2 Instances**: Configured through a modular launch configuration using Amazon Linux 2 and `t2.micro` instance type.
- **Task Definition**: Supports both Fargate and EC2, with modular container definitions.
- **ECS Service**: Deployed using AWS Fargate with specific deployment configurations.
- **Application Load Balancer (ALB)**: Distributes traffic to ECS services, with modular configuration for health checks and target groups.

## Components

1. **ECS Cluster (Module: `ecs_cluster`)**
   - Creates an ECS Cluster with a customizable name.
   - Supports both Fargate and EC2 launch types.

2. **Auto Scaling Group (Module: `autoscaling_group`)**
   - Configures an Auto Scaling Group with the following default settings:
     - Desired capacity: `0`
     - Minimum capacity: `0`
     - Maximum capacity: `3`
   - Utilizes a modular launch configuration to define EC2 instance settings.
   - Configured to work seamlessly with the ECS Cluster.

3. **EC2 Launch Configuration (Module: `launch_configuration`)**
   - Uses Amazon Linux 2 with a customizable instance type (default: `t2.micro`).
   - Attaches a security group module allowing inbound HTTP traffic on port 80.
   - Initializes the ECS agent on EC2 instances to join the specified ECS Cluster.

4. **Task Definition (Module: `ecs_task_definition`)**
   - Defines the ECS task, supporting both Fargate and EC2 launch types.
   - Configurable resources including CPU (default: `512` units) and memory (default: `3072` MB).
   - Modular container definition with support for multiple containers if needed.

5. **ECS Service (Module: `ecs_service`)**
   - Manages the ECS Service with the following default settings:
     - Launch type: `FARGATE`
     - Platform version: `LATEST`
     - Desired task count: `1`
   - Configured to work with an ALB module for traffic distribution.

6. **Application Load Balancer (Module: `alb`)**
   - Configures an ALB to distribute incoming HTTP traffic on port 80.
   - Integrated with the ECS Service module for seamless operation.
   - Modular target group and health check configurations to ensure high availability.

## How It Works

- **ECS Cluster**: Acts as the logical grouping for tasks and services, configured through a dedicated module.
- **Auto Scaling Group**: Dynamically manages EC2 instances to meet the desired capacity, defined by a modular launch configuration.
- **Task Definition**: Provides a flexible and modular approach to define how containers should run, with options for both Fargate and EC2.
- **ECS Service**: Ensures that the desired number of tasks are running, leveraging the modular ALB for load balancing.
- **Application Load Balancer**: Routes incoming traffic to the ECS service and performs health checks, all configured within a modular setup.

## Usage

1. **Initialize Terraform**

   Navigate to the root directory of your Terraform configuration and run the following commands to deploy the infrastructure:

   ```bash
   terraform init
   terraform plan
   terraform apply -auto-approve
