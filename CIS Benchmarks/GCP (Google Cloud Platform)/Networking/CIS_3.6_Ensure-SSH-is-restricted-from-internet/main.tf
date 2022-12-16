resource "google_compute_network" "network" {
  name = var.networkname
}

resource "google_compute_firewall" "default" {
  name = var.firewallname
  network = google_compute_network.network.name
  source_ranges = var.sourceranges
  
 allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}