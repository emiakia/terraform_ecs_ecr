output "launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = aws_launch_configuration.launch_config.id
}
