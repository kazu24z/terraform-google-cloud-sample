resource "google_sql_database_instance" "main" {
  name             = var.cloudsql_instance_name
  database_version = "MYSQL_8_0_37"
  region           = var.region
  
  settings {
    tier = "db-custom-1-3840"
  }

  deletion_protection = true
}

resource "google_sql_database" "main" {
  name = var.cloudsql_database_name
  instance = google_sql_database_instance.main.name
  charset  = "utf8mb4"
  collation = "utf8mb4_unicode_ci" 
}
