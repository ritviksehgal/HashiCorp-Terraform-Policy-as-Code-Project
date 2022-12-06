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

resource "google_os_config_patch_deployment" "patch" {
  patch_deployment_id = "patch-deploy"
      
  
  //This patch configuration will apply to all VMs in a project
  instance_filter {
    all = true
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


  // Reboot the VM after the patches are deployed, if needed
  patch_config {

    reboot_config = "DEFAULT"


    //Patch configuration for Linux VMs: Debian, Ubuntu
    //apt-get upgrade: Only upgrades the most important packages that are needed.
    //Apt-get UPGRADE does not remove packages, it only upgrades.
    apt {
      type = "UPGRADE"
    }

    //Patch configuration for Linux VMs: RHEL, CentOS.
    //Installs all security updates
    yum {
      security = true
    }


    //Patch configuration for Linux Enterprise servers: SuSE (German-based open-source software firm).
    //Security updates / patches will be installed
    zypper {
      categories = ["security"]
      with_update = true
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