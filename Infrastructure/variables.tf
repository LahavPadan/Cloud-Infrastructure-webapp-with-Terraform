variable "CONFIG" { # 'dev' OR 'prod'
  description = "Defines seperate dev and prod infrastructre"
  type        = string
}

variable "PROJECT_ID" {
  description = "The ID of the project in which resources will be provisioned"
  type        = string
}


variable "REGION"{
  description = "Region in which to deploy"
  type        = string
}


variable "zones" {
    type        = list
    description = "Zones (in the above region) for GKE cluster"
}


variable "instanceGroup_num_instances" {
  type        = number
  description = "Number of instances in instance group"
}


variable "preemptible" {
  type = bool
}

variable "app_min_cpu_instances"{ type = number }
variable "app_max_cpu_instances"{ type = number }
variable "app_min_memory_instances"{ type = number }
variable "app_max_memory_instances"{ type = number }
variable "postgres_min_cpu_instances"{ type = number }
variable "postgres_max_cpu_instances"{ type = number }
variable "postgres_min_memory_instances"{ type = number }
variable "postgres_max_memory_instances"{ type = number }

