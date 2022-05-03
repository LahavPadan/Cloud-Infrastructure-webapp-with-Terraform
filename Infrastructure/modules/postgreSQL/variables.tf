variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "instance_name" {
  description = "Name of the db instance"
  type = string
}

variable "db_name" { 
  description = "Name of the concrete db inside the instance"
  type        = string
}

variable "dbRoot_password" {
  description = "Password for the db root user"
  type        = string
  sensitive   = true
}

variable "dbInstance_region" {
  description = "Zone for db instance" 
  type        = string
}

variable "tier" { default = "db-custom-2-13312" }
variable "disk_size" { default = "20" }
variable "database_version" { default = "POSTGRES_11" }
variable "activation_policy" { default = "ALWAYS" }