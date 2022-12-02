terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
    }
  }
}

provider "google" {
  project = "fleet-authority-362616"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"


# Create keyring
}
resource "google_kms_key_ring" "keyring-bad" {
  name     = "keyring-bad"
  location = "global"
}


# !!! Rotation period will be checked to enforce 90 days
resource "google_kms_crypto_key" "example-key" {
  name            = "crypto-key-bad"
  key_ring        = google_kms_key_ring.keyring-bad.id
  rotation_period = "100000s"
}

resource "google_kms_key_ring" "keyring-good" {
  name     = "keyring-good"
  location = "global"
}
# !!! Rotation period will be checked to enforce 90 days
resource "google_kms_crypto_key" "example-key1" {
  name            = "crypto-key-good"
  key_ring        = google_kms_key_ring.keyring-good.id
  rotation_period = "200000s"

}
