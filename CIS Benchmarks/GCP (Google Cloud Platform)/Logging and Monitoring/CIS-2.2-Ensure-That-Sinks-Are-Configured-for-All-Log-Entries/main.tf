terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
    }
  }
}

provider "google" {
  project = "agile-being-364017"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"

}


//create a project- level storage sink for ALL project level audit logs. A unique service account is used to write the logs to ensure accountability 
resource "google_logging_project_sink" "my-sink" {
  name = "my_sink_for_all_logs"
  destination = "logging.googleapis.com/projects/agile-being-364017/locations/us-east1/buckets/Cloud_Log_All_Logs"
  unique_writer_identity = true
}


//create a folder- level storage sink for ALL folder level audit logs
resource "google_logging_folder_sink" "my-sink" {
  name   = "my-folder-sink"
  description = "some explanation on what this is"
  folder = "storage-folder-1"
  destination = "storage.googleapis.com/storage-folder-1"

  
}
