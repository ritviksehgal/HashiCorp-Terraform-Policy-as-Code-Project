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


data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = "us-central1"
}

provider "kubernetes" {
  host  = "http://34.66.160.91"
  token = data.google_client_config.provider.access_token

}

// Here, we are will ensure that the kubernetes default service account does not auto mount an access token (false). The default value is true, it is a best practice to define the automount_service_account_token as 'false'.
//Kubernetes service accounts (including the default service account) are Kubernetes resources (not google resources), created and managed using the Kubernetes API
//Kubernetes service accounts are created via the Kubernetes Provider
// Default service accounts should not be used to complete production activities  


resource "kubernetes_default_service_account" "example" {
  metadata {
    namespace = "terraform-example"

}

automount_service_account_token = false

}
