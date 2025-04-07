output "sql_user_name" {
  description = "The name of the SQL user."
  value       = google_sql_user.cloudrun_app.name
}

output "sql_user_password" {
  description = "The generated password for the SQL user."
  value       = random_password.sql_user_password.result
  sensitive   = true
}

output "cloudsql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance."
  value       = google_sql_database_instance.main.connection_name
}

output "cloudsql_database_name" {
  description = "The name of the Cloud SQL database."
  value       = google_sql_database.main.name
}
