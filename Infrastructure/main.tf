# module "postgreSQL"{
#   source            = "./modules/postgreSQL"
#   project_id        = var.PROJECT_ID
#   instance_name     = "hw2-${var.CONFIG}-instance"
#   db_name           = "hw2-${var.CONFIG}-db"
#   region = var.REGION
#   dbRoot_password   = var.POSTGRES_PASSWORD
# }


module "webapp"{
  source = "./modules/GKE_cluster"
  project_id  = var.PROJECT_ID
  clustername = "hw2.${var.CONFIG}.webapp_cluster"
  num_instances = var.instanceGroup_num_instances
  preemptible = var.preemptible
  region = var.REGION
}
