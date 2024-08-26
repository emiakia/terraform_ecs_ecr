resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  launch_configuration = var.launch_configuration_id
  vpc_zone_identifier  = var.subnet_ids

  tag {
    key                 = var.tag_key
    value               = var.tag_value
    propagate_at_launch = true
  }
}
