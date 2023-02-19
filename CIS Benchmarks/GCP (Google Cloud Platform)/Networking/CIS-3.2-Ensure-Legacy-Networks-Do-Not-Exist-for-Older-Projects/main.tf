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


// Create a network in Google Cloud

resource "google_compute_network" "vpc_network_bad" {
  name = "vpc-legacy"
  
  // In order to create a modern and secure network, the following is a best practice: the creation of subnets, to properly segment the network (auto_create_subnetworks = true). REGIONAL routing (as opposed to GLOBAL routing) ensures that routers advertise routes only to networks and networked devices within the same avalibility zone.
  auto_create_subnetworks = true
  routing_mode = "REGIONAL"
  project = "agile-being-364017"
}
