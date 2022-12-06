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


//Below, we are creating 2 google applications on the Google Application Engine: 1. A standard application version 2. A flexible application version
//The flexible version does not have a security_level defined, while the standard version does
//The security level 'SECURE_ALWAYS' indicates that the Application enforces HTTPS connections (HTTP connections are redirected to an HTTPS endpoint)


resource "google_app_engine_standard_app_version" "myapp_v1" {
  version_id = "v1"
  service    = "myapp"
  runtime    = "nodejs10"

  entrypoint {
    shell = "node ./app.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/"
    }
  }
    handlers {
    security_level   = "SECURE_ALWAYS"
  }
}


resource "google_app_engine_flexible_app_version" "myapp_v1" {
  version_id = "v1"
  project    = "google_project_iam_member.gae_api.project"
  service    = "default"
runtime    = "nodejs"

  entrypoint {
    shell = "node ./app.js"
  }

  liveness_check {
    path = "/"
  }

  readiness_check {
    path = "/"
  }

  handlers {


  }
  automatic_scaling {
    cool_down_period = "120s"
    cpu_utilization {
      target_utilization = 0.5
    }
  }
}



