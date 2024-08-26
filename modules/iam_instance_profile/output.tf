output "instance_profile_id" {
  description = "The ID of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.id
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.name
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.arn
}
