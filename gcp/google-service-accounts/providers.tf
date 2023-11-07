terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {
  project     = "${YOUR_PROJECT_ID}"
  region      = "us-west2"
}