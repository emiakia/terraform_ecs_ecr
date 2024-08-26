variable "sg_name" {
  type        = string
  description = "Name of the security group"
  default     = "ecs_sg"
}

variable "sg_description" {
  type        = string
  description = "Description of the security group"
  default     = "Allow inbound access on port 80"
}

variable "sg_vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "sg_ingress_from_port" {
  type        = number
  description = "Starting port for ingress rule"
  default     = 80
}

variable "sg_ingress_to_port" {
  type        = number
  description = "Ending port for ingress rule"
  default     = 80
}

variable "sg_ingress_protocol" {
  type        = string
  description = "Protocol for ingress rule"
  default     = "tcp"
}

variable "sg_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for ingress rule"
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_from_port" {
  type        = number
  description = "Starting port for egress rule"
  default     = 0
}

variable "sg_egress_to_port" {
  type        = number
  description = "Ending port for egress rule"
  default     = 0
}

variable "sg_egress_protocol" {
  type        = string
  description = "Protocol for egress rule"
  default     = "-1" # All protocols
}

variable "sg_egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for egress rule"
  default     = ["0.0.0.0/0"]
}
