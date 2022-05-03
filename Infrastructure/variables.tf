variable "config" { # 'dev' OR 'prod'
  description = "Defines seperate dev and prod infrastructre"
  type        = string
}

variable "PROJECT_ID" {
  description = "The ID of the project in which resources will be provisioned"
  type        = string
}

variable "POSTGRES_PASSWORD"{
  description = "Password for the postgreSQL database"
  type        = string
  sensitive   = true
}

variable "WS_DOCKERIMAGE"{
  description = "Dockerimage path the webserver container"
  type        = string
}

variable "dbInstance_region" {
  description = "Region in which to deploy the instance group"
  type        = string
}

variable "instanceGroup_num_instances" {
  type        = number
  description = "Number of instances in instance group"
}

variable "preemptible" {
  type = bool
}