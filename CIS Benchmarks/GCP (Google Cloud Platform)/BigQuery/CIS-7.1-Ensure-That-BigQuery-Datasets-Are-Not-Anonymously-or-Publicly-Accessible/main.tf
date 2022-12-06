terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
     }
  }
}

provider "google" {
  project = "elevated-module-365823"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"

}

resource "google_bigquery_dataset_iam_binding" "reader" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  role       = "roles/bigquery.dataViewer"

  members = [
    "allUsers",
    "allAuthenticatedUsers"
  ]
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "example_dataset"
}