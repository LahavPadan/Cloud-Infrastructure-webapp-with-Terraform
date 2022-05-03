
# module "postgreSQL"{
#   source            = "./modules/postgreSQL"
#   project_id        = var.PROJECT_ID
#   instance_name     = "hw2.${var.config}.postgreSQL.instance"
#   db_name           = "hw2.${var.config}.postgreSQL.db"
#   dbInstance_region = var.dbInstance_region
#   dbRoot_password   = var.POSTGRES_PASSWORD
# }


module "webapp"{
  source = "./modules/GKE_cluster"
  project_id  = var.PROJECT_ID
  clustername        = "hw2.${var.config}.webapp_cluster"
  num_instances = var.instanceGroup_num_instances
  preemptible = var.preemptible
  zone = "us-west1-b"
}



# module "webserver"{
#   source      = "./modules/webserver"
#   project_id  = var.PROJECT_ID
#   name        = "hw2.${var.config}.webserver"
#   preemptible = var.preemptible
#   dockerImage = var.WS_DOCKERIMAGE
# }

# module "instanceGroup"{
#   source             = "./modules/instanceGroup"
#   # project_id         = var.PROJECT_ID
#   # instanceGroup_name = "hw2.${var.config}.instanceGroup"
#   # instance_name      = module.webserver.name
#   # num_instances      = var.instanceGroup_num_instances
#   ws_dockerImage = var.WS_DOCKERIMAGE
# }


# module "containered_managedInstanceGroup"{
#   source = "./modules/container_InstanceGroup"
#   project_id = var.PROJECT_ID
#   mig_name = "hw2.${var.config}.instanceGroup"
#   mig_instance_count = var.instanceGroup_num_instances
#   image = var.WS_DOCKERIMAGE
#   image_port = 5000 # flask webapp
#   zone = "us-west1"
#   region = "us-west1-b"
#   service_account = {email = module.vm_serviceAccount.email, scopes=""}
# }

# module "vm_serviceAccount" {
#   source        = "terraform-google-modules/service-accounts/google"
#   version       = "~> 3.0"
#   project_id    = var.PROJECT_ID
#   prefix        = "test-sa"
#   names         = ["first", "second"]
#   project_roles = [
#   ]
# }