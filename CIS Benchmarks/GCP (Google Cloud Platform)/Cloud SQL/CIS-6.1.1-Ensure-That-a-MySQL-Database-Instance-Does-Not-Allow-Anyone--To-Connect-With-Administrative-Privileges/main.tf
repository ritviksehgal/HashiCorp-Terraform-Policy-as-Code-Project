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


resource "google_sql_database_instance" "my-instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  root_password = "123456"
  settings {
    tier = "db-f1-micro"
  
password_validation_policy {
      enable_password_policy = true
      disallow_username_substring = true
      min_length = 5
      reuse_interval = 3
    }
  }
}

resource "google_sql_user" "users" {
    name     = "user1"
    instance = google_sql_database_instance.my-instance.name
    password = "test1"
  }