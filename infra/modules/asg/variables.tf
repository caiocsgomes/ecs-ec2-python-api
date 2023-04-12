variable "project_name" {}

variable "asg_max_size" {
  type        = number
  default     = 1
  description = "The maximum size of the autoscaling group"
}

variable "asg_min_size" {
  type        = number
  default     = 1
  description = "The minimum size of the autoscaling group"
}

variable "asg_desired_capacity" {
  type        = number
  default     = 1
  description = "The desired capacity of the autoscaling group"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The instance type of the autoscaling group"
}

variable "subnets" {
  type        = list(string)
  default     = []
  description = "A list of subnets to use for the autoscaling group"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "The name of the ECS cluster"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC"
}

variable "alb_sg" {
  type        = string
  default     = ""
  description = "The ID of the ALB security group"
}

variable "task_port" {
  type        = number
  default     = 80
  description = "The port of the container"
}
