
resource "google_container_cluster" "postgres" {
  name               = "postgres-demo-k8s"  # cluster name
  location          = var.region
  node_locations = var.zones
  initial_node_count = 1           # number of node (VMs) for the cluster
  
  # master_auth {
  #   username = ""
  #   password = ""
  #   client_certificate_config {
  #     issue_client_certificate = false
  #   }
  # }

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    tags = ["postgres-demo-k8s"]
  }
}
# -------------------------------------------------------------*
# Next, we create firewall rule to allow access to application
# -------------------------------------------------------------*
resource "google_compute_firewall" "postgresports" {
  name    = "postgres-port-range"
  network = google_compute_network.postgres_default.name
  allow {
    protocol = "tcp"
    ports    = ["5432"]  
  }
  source_ranges = ["0.0.0.0/0"]
}   

resource "google_compute_network" "postgres_default" {
  name = "postgres-network"
}