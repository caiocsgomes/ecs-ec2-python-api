variable "project_name" {}
variable "cluster_name" {}
variable "ecs_service_name" {}
variable "task_name" {}
variable "task_image" {}
variable "task_cpu" {}
variable "task_memory" {}
variable "task_port" {}
variable "vpc_id" {}
variable "cluster_listener" {}
variable "alb_sg" {}
variable "asg_arn" {}
variable "tg_arn" {}
variable "region" {}
variable "subnets" {}
variable "ecs_service_path" {
  description = "value of the path for the listener rule"
  default     = "/*"
}
variable "allowed_sg_connection" {
  type        = list(string)
  default     = []
  description = "A list of all sgs allowed to connect with the service"
}
variable "env" {
  type        = string
  default     = "prod"
  description = "The environment of the service"
}
variable "db_host" {
  type        = string
  default     = ""
  description = "The database host"
}
variable "db_name" {
  type        = string
  default     = ""
  description = "The database name"
}
variable "sm_db_user_secret_name" {
  type        = string
  default     = ""
  description = "The database user secret name in Secrets Manager"
}
variable "sm_db_password_secret_name" {
  type        = string
  default     = ""
  description = "The database password secret name in Secrets Manager"
}

