
resource "google_container_cluster" "primary" {
  name               = "node-demo-k8s"  # cluster name
  location          = var.region
  initial_node_count = var.num_instances           # number of node (VMs) for the cluster
  
  # master_auth {
  #   username = ""
  #   password = ""
  #   client_certificate_config {
  #     issue_client_certificate = false
  #   }
  # }

  node_config {
    preemptible  = var.preemptible
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
    tags = ["node-demo-k8s"]
  }
}
# -------------------------------------------------------------*
# Next, we create firewall rule to allow access to application
# note: in our deploy.yml we set and know that
# The range of valid ports in kubernetes is 30000-32767
# -------------------------------------------------------------*
resource "google_compute_firewall" "nodeports" {
  name    = "node-port-range"
  network = google_compute_network.default.name
  allow {
    protocol = "tcp"
    # valid ports in kubernetes is 30000-32767
    # port 80 for HTTP and 443 for HTTPS
    # port 22 for SSH into the node and pod if needed
    ports    = ["30000-32767", "80", "443", "8080", "22"]  
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}   

resource "google_compute_network" "default" {
  name = "test-network"
}