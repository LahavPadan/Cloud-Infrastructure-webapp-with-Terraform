
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.45"
    }
  }
}

# provider "random" {
#   version = "~> 2.2"
# }

# provider "template" {
#   version = "~> 2.2"
# }

provider "google" {
  project = var.PROJECT_ID
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "google-beta" {
  project = var.PROJECT_ID
}
