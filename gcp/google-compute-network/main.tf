terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("/Users/akalaj/.gcp/creds/ise-akalaj-dev-1dd82f12b73c.json")

  project = "ise-akalaj-dev"
  region  = "us-west1"
  zone    = "us-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network2"
}
