variable "project_id" {
    description = "The ID of the project in which resources will be provisioned."
    type        = string
}

variable "region" {
    type        = string
    description = "Region for GKE cluster"
}

variable "zones" {
    type        = list
    description = "Zones (in the above region) for GKE cluster"
}


variable "clustername" {
    description = "GKE cluster name"
    type        = string
    default = "node-demo-k8s"
}


variable "num_instances" {
    type        = number
    description = "Number of instances in instance group"
}
