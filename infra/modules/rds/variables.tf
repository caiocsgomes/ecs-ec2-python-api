variable "memory_size" {
  type        = string
  default     = 20
  description = "Memory allocated for the database, usually it needs to be bigger than 20GB."
  validation {
    condition     = var.memory_size >= 20
    error_message = "The database size need to be at least 20GB."
  }
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "14.2"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "DB instance class used for the DB (default is t3.micro)."
}

variable "allowed_sg_connection" {
  type        = list(string)
  default     = []
  description = "A list of all sgs allowed to connect with the DB"
}

variable "default_port" {
  type        = number
  default     = 5432
  description = "The default port for DB. Its 5432 in case portgresql is used"
}

variable "db_username" {
  default = "dbadmin"
}

variable "backup_window" {
  default = "01:00-02:00"
}

variable "storage_type" {
  default = "gp2"
}

variable "db_name" {}

variable "subnet_ids" {}

variable "vpc_id" {}