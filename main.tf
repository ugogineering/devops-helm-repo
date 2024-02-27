terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  project = ""
  region  = "us-central1"
  zone    = "us-central1-c"
}
# Creating a GCS bucket to store Helm charts
resource "google_storage_bucket" "helm_repository" {
  name          = "ugo-bucket-270224"
  location      = "US"
  force_destroy = true
}

# Enabling website configuration on ugo-bucket 
resource "google_storage_bucket_website" "helm_repository_website" {
  bucket = google_storage_bucket.helm_repository.name

  homepage_suffix = "index.yaml"
}

# Configuring CORS setting to allow Helm clients to access bucket
resource "google_storage_bucket_iam_member" "helm_repository_cors" {
  bucket = google_storage_bucket.helm_repository.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
