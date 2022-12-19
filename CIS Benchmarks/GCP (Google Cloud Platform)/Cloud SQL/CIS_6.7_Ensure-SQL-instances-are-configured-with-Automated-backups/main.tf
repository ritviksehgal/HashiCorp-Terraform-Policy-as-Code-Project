resource "google_sql_database_instance" "main" {
  name             = var.sqlinstancename
  database_version = var.databaseversion
  region           = var.Region
  root_password = var.rootpassword

  settings {
    backup_configuration {
      enabled = var.Enabled
      start_time = var.starttime
    }
    tier = var.Tier
  }
  # deletion_protection is set to true to prevent destruction of the resource
  deletion_protection = var.deletionprotection
}