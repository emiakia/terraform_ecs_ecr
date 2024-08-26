resource "aws_launch_configuration" "launch_config" {
  name          = var.launch_config_name
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = [
    var.security_group_id
  ]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
              EOF

  iam_instance_profile = var.iam_instance_profile_name
}
