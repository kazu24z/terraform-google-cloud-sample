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

resource "random_password" "sql_user_password" {
  length           = 16
  special          = false
}

resource "google_sql_user" "cloudrun_app" {
  project = google_sql_database_instance.main.project
  name     = "cloudrun_app" 
  host     = "%"
  password = random_password.sql_user_password.result
  instance = google_sql_database_instance.main.name
  type     = "BUILT_IN"
}
