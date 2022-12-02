terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
     }
  }
}

provider "google" {
  project = "daring-bit-365423"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"

}


//Configuring audit logging at the project level
resource "google_project_iam_audit_config" "project-logging" {
  project = "daring-bit-365423"
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"

  }
  audit_log_config {
    log_type = "DATA_WRITE"

  }
    audit_log_config {
    log_type = "DATA_READ"

  }
}

//Configuring audit logging at the folder level
resource "google_folder_iam_audit_config" "config" {
  folder = "folders/{folder_id}"
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"

  }
  audit_log_config {
    log_type = "DATA_WRITE"

  }
    audit_log_config {
    log_type = "DATA_READ"

  }
}

//Configuring audit logging at the organization level
resource "google_organization_iam_audit_config" "organization" {
  org_id = "your-organization-id"
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"

  }
  audit_log_config {
    log_type = "DATA_WRITE"

  }
    audit_log_config {
    log_type = "DATA_READ"

  }
}
