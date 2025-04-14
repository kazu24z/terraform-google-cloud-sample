data "google_project" "project" {}
module "api" {
  source = "./modules/api"
}

module "iam" {
  source          = "./modules/iam"
  
  project_id      = var.project_id
  terraform_state_bucket_name = var.terraform_state_bucket_name
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  region = var.region
  artifact_registry_repository_name = var.artifact_registry_repository_name
}

module "cloud_run" {
  source = "./modules/cloud_run"

  project_id = var.project_id
  region = var.region
  cloud_run_service_name = var.cloud_run_service_name
  artifact_registry_image_name = var.artifact_registry_image_name
  artifact_registry_repository_name = var.artifact_registry_repository_name
  cloudsql_instance_connection_name = module.cloud_sql.cloudsql_instance_connection_name

  cloud_run_sa_email = module.iam.cloud_run_sa_email
  secret_id = module.secret_manager.secret_id
}

# 接続文字列を構築するためのローカル変数
locals {
    # mysql://cloudrun_app:<PASSSWORD>@localhost/<PROJECT_ID>?socket=/cloudsql/<CLOUD_SQL_INSTANCE_CONNECTION_NAME>
    database_url = "mysql://${module.cloud_sql.sql_user_name}:${module.cloud_sql.sql_user_password}@localhost/${local.project_display_name}?socket=/cloudsql/${module.cloud_sql.cloudsql_instance_connection_name}"
    project_display_name = data.google_project.project.name
}

module "secret_manager" {
  source = "./modules/secret_manager"
  
  database_connection_string = local.database_url

  depends_on = [
    module.api,
    module.cloud_sql
  ]
}

module "cloud_sql" {
  source = "./modules/cloud_sql"

  region = var.region
  cloudsql_instance_name = var.cloudsql_instance_name
  cloudsql_database_name = var.cloudsql_database_name
  cloud_run_sa_email = module.iam.cloud_run_sa_email
}
