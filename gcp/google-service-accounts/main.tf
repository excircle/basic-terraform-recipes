data "google_project" "project" {}

# Define Role
data "google_iam_role" "gcp_compute_admin" {
  name = "roles/compute.admin"
}

# Create Service Account
resource "google_service_account" "tf_sa" {
  account_id   = "terraform-service-account"
  display_name = "Terraform Service Account"
}

# Pull role from Project to assign
resource "google_project_iam_member" "tf_sa_compute_admin_membership" {
  project = data.google_project.project.project_id
  role    = data.google_iam_role.gcp_compute_admin.name
  member  = "serviceAccount:${google_service_account.tf_sa.email}"
}