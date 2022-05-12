variable "type" {
    description = "The type of object in the cluster (e.g database, or webapp)"
}

variable "project_id" {
    description = "The ID of the project in which resources will be provisioned"
    type        = string
}

variable "region" {
    type        = string
    description = "Region for GKE cluster"
}

variable "zones" {
    description = "Zones (in the above region) for GKE cluster"
    type        = list
}

variable "num_instances" {
    description = "Number of instances in instance group"
    type        = number
}

variable "ports"{
    description = "TCP ports to open"
    type = list
}

variable "min_cpu_instances"{ type=number }
variable "max_cpu_instances"{ type=number }
variable "min_memory_instances"{ type=number }
variable "max_memory_instances"{ type=number }
variable "preemptible" { type = bool }


