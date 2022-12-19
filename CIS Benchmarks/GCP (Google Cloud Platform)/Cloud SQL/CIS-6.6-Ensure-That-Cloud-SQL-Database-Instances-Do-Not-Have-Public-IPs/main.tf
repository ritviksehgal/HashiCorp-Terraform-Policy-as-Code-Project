terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
     }
  }
}

provider "google" {
  project = "formidable-rune-366200"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"

}


// Creating a network, defining where the SQL database will reside 
resource "google_compute_network" "private_network" {
  name = "vpc-network2"
  auto_create_subnetworks = true
}

// Define a private IP address for the database instance
resource "google_compute_global_address" "private_ip_address" {
  name          = "global-connect-ip"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  network       = google_compute_network.private_network.id
  prefix_length = 16

}

 // Create a private connection from the instance to the Google service provider. Configure the private connection to assign the instance a private IP address from the VPC network INTERNAL IP ranges (reserved_peering_ranges)
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

// Create the actual SQL database instance and define the necessary attributes. Assign the instance the private connection
resource "google_sql_database_instance" "default" {
  name             = "test-instance"
  database_version = "POSTGRES_14"
  region           = "us-central1"
  depends_on = [google_service_networking_connection.private_vpc_connection]
 
  settings {
    tier = "db-f1-micro"
    ip_configuration {
    ipv4_enabled = false // Do not assign the Instance a public IP address 
    private_network = google_compute_network.private_network.id
            
    }
  }
}
