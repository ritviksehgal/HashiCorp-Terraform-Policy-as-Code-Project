terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.36.0"
    }
  }
}

provider "google" {
  project = "fleet-authority-362616"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = "keys.json"
}

resource "google_compute_network" "Prod-network" {
  name = "PROD"
  auto_create_subnetworks = true
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = true
  
}


resource "google_compute_instance" "default" {
  name = "VM running Linux- based containers"
  machine_type = "e2-micro"
    boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019-for-containers"
    }
}

    network_interface {
    network = "default"
    network_ip = "10.0.0.1/32"
}
allow_stopping_for_update = true
deletion_protection = true
shielded_instance_config {
  enable_secure_boot = true
  enable_vtpm = true
  enable_integrity_monitoring = true
}
}



resource "google_os_config_patch_deployment" "patch" {
  patch_deployment_id = "patch-deploy"
      
  
  //This patch configuration will apply to all VMs in a project
 instance_filter {
    instances = [google_compute_instance.default.id]
  }

  //This patch job will run of the last Tuesday of every Month at 12:00 AM EST (Midnight)
  recurring_schedule {
        time_zone {
      id = "America/New_York"
    }
    time_of_day {
      hours = 0
      minutes = 30
      seconds = 30
      nanos = 20

  }

     monthly {
      week_day_of_month {
        week_ordinal = -1
        day_of_week  = "TUESDAY"
      }
    }
  }

    //Patch configuration for all Windows- based operating systems.
    //All updates with a Critical severity will be installed. Security updates/ patches will be installed as well 
    windows_update {
      classifications = ["SECURITY", "CRITICAL"]
    }
  }

      //Updates and patches will be applied 1 zone at a time to ensure minimal downtime
      rollout {
        mode = "ZONE_BY_ZONE"

        //1 VM per avalibility zone will update at a time to ensure minimal downtime
        disruption_budget {
          fixed = 1
        }
      }
    }

resource "google_compute_firewall" "network-firewall" {
    name = "allow-secure-traffic"
    network = "Prod-network"
    description = "This firewall allows FTP, HTTPS traffic on the Network level only"
    source_ranges = ["20.0.0.0/24"]
    allow {
    protocol = "tcp, udp"
    ports    = ["22", "21", "443"]
    }
    priority = 100
    enable_logging = true
}


resource "google_compute_router" "router1" {
  name     = "router1"
  network  = "Prod-network"
  bgp {
    asn = 64514
    advertised_groups = ["ALL_SUBNETS"]
  }
}


resource "google_compute_router_nat" "nat-server" {
  name  = "my-router-nat"
  region= "us-east1"
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  router = "router1"


}


#If a service account is required to perform operations, explicity create one for increased accountibility among users.
resource "google_project_default_service_accounts" "Prod-Env" {
  project = "185937"
  action = "DELETE"
}

resource "google_logging_folder_sink" "my-sink" {
  name   = "my-folder-sink"
  description = "some explanation on what this is"
  folder = "storage-folder-1"
  destination = "storage.googleapis.com/storage-1"

  
}

resource "google_logging_organization_sink" "aggerate-all-logs" {
  name   = "general-purpose-sink"
  description = "Prepare all logs for export to SIEM (Security Information and Event Management) tool"
  org_id = "123456789"

  destination = "storage.googleapis.com"

  # Log all severity messages relating to instances
  filter = null
}

resource "google_compute_ssl_policy" "prod-ssl-policy" {
  name            = "prod-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "CUSTOM"
  custom_features = [
    "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256",
    "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",

  ]
}

resource "google_compute_target_ssl_proxy" "for-outbound-traffic" {
  name             = "client-side proxy"
  ssl_policy = google_compute_ssl_policy.prod-ssl-policy.id
}

resource "google_sql_database_instance" "internal-emp-DB" {
  name             = "HR-instance"
  database_version = "POSTGRES_14"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
    database_flags {
      name = "cloudsql.enable_pgaudit"
      value = "on"
    }

    database_flags {
      name = "log_statement"
      value = "on"
    }
  }
}


resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "Infra-Management" {
  name     = "gke-cluster-for-resource-management"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}
