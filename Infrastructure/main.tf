module "webapp"{
  source = "./modules/GKE_cluster"
  type = "${var.CONFIG}-webapp"
  project_id  = var.PROJECT_ID
  num_instances = var.instanceGroup_num_instances
  preemptible = var.preemptible
  region = var.REGION
  zones = var.zones
  min_cpu_instances = var.app_min_cpu_instances
  max_cpu_instances = var.app_max_cpu_instances
  min_memory_instances = var.app_min_memory_instances
  max_memory_instances = var.app_max_memory_instances
  ports = ["30000-32767", "80", "443", "8080", "22"]  
}

module "postgreSQL"{
  source = "./modules/GKE_cluster"
  type = "${var.CONFIG}-postgres"
  project_id  = var.PROJECT_ID
  num_instances = var.instanceGroup_num_instances
  region = var.REGION
  zones = var.zones
  min_cpu_instances = var.postgres_min_cpu_instances
  max_cpu_instances = var.postgres_max_cpu_instances
  min_memory_instances = var.postgres_min_memory_instances
  max_memory_instances = var.postgres_max_memory_instances
  ports = ["5432"] 
  preemptible = false 
}
