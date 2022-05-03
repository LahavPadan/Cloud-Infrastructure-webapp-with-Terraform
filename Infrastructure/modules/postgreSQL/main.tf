# Defining a DB has two steps - we define a SQL database instance (mentally map to a DB server or cluster) and a concrete database inside of it.

###################### defines a SQL database instance ######################
resource "google_sql_database_instance" "sqlserver" {
  project = var.project_id
  provider = google-beta
  region           = var.dbInstance_region
  database_version = var.database_version
  name             = var.instance_name
  root_password = var.dbRoot_password
    
  settings {
    ip_configuration {
      ipv4_enabled    = true
      private_network = null
      require_ssl     = false
    }

    tier              = var.tier
    disk_size         = var.disk_size
    activation_policy = var.activation_policy
  }
}

###################### concrete database inside of it ######################

resource "google_sql_database" "db" {
  provider = google-beta
  name     = var.db_name
  instance = google_sql_database_instance.sqlserver.name
  project = var.project_id
}
