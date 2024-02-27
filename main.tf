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

  uniform_bucket_level_access = true 

  website {
    main_page_suffix = "index.yaml"
    not_found_page = "404.html"
  }
  cors {
    origin = ["*"]
    #origin = ["https://caseray.com.ng"]
    method = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

}

# Configuring CORS setting to allow Helm clients to access bucket
resource "google_storage_bucket_iam_member" "helm_repository_cors" {
  bucket = google_storage_bucket.helm_repository.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
