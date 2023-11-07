# Creating Google Service Accounts with Terraform

`<rant>`</br>
>For some reason I can't quite describe, I hate Google Cloud Platform Identity and Access Management (IAM). It is convoluted and the API for managing it is really ineffectual.
>
>The main thing for me is the APIs meager abilities to describe what you have, what you've done, and what you can do.
>
>My opinion on the massive short-comings of the GCP API come from my use of Terraform for GCP.
>
>The creation and maintenance of Service Accounts on GCP using Terraform are the simpliest way to >understand what's happening behind the scenes (when using the API), but that still doesn't really >rationalize why Google is doing things the way they are.

>What I am going to display on this page seems very easy and straightforward, but that is only because I have done hours of work to find out how to do this. Since I am not a big user or fan of GCP, I will not say this is the safest method of doing things. Please use the contents of this page for learning purposes only!


`</rant>`

# Creating A Service Account and Assigning It A Role

For the sake of learning, the following Terraform code is meant to illustrate what API constucts will need to be utilized when creating a GCP Service Account and assigning it a generic, GCP-managed role.


### providers.go
```hcl
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
```

### main.tf
```hcl
# GCP Project Data
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

```