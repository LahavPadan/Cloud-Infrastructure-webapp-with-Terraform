
resource "google_container_cluster" "postgres" {
  name               = "postgres-demo-k8s"  # cluster name
  location          = var.region
  node_locations = var.zones
  initial_node_count = 1           # number of node (VMs) for the cluster
  
  cluster_autoscaling {
    enabled = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    resource_limits {
      resource_type = "cpu"
      minimum = var.min_cpu_instances
      maximum = var.max_cpu_instances
    }
    resource_limits {
      resource_type = "memory"
      minimum = var.min_memory_instances
      maximum = var.max_memory_instances
    }
  }

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





resource "google_container_cluster" "app" {
  name               = "node-demo-k8s"  # cluster name
  location          = var.region
  node_locations = var.zones
  initial_node_count = var.num_instances   # number of nodes (VMs) for the cluster

  cluster_autoscaling {
    enabled = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    resource_limits {
      resource_type = "cpu"
      minimum = var.min_cpu_instances
      maximum = var.max_cpu_instances
    }
    resource_limits {
      resource_type = "memory"
      minimum = var.min_memory_instances
      maximum = var.max_memory_instances
    }
  }

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


resource "google_compute_firewall" "appports" {
  name    = "appports-range"
  network = google_compute_network.app_default.name
  allow {
    protocol = "tcp"
    ports    = ["30000-32767", "80", "443", "8080", "22"]  
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}   

resource "google_compute_network" "app_default" {
  name = "app-network"
}
