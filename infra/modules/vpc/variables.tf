variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west-1a"
}

variable "environment" {
  description = "The name of the environment"
}

variable "subnet_public_cidrs" {
  type        = list(any)
  description = "List of cidrs for public subnets. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "subnet_private_cidrs" {
  type        = list(any)
  description = "List of cidrs for private subnets. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones you want. Example: eu-west-1a and eu-west-1b"
}
