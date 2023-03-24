variable "project_name" {}

variable "region" {
  default = "us-east-1"
}

variable "hosted_zone" {}

variable "task_name" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_public_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_private_cidrs" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  default = "prod"
}

variable "container_image" {}

variable "task_cpu" {
  default = "256"
}

variable "task_memory" {
  default = "512"
}

variable "task_container_port" {}

