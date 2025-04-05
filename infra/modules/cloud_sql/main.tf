resource "google_sql_database_instance" "main" {
  name             = var.cloudsql_instance_name
  database_version = "MYSQL_8_0_37"
  region           = var.region
  
  settings {
    tier = "db-custom-1-3840"
  }

  deletion_protection = true
}
