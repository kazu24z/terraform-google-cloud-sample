module "api" {
  source = "./modules/api"
}

module "iam" {
  source          = "./modules/iam"
  
  project_id      = var.project_id
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
}

module "secret_manager" {
  source = "./modules/secret_manager"
  
  depends_on = [
    module.api,
  ]
}

module "cloud_sql" {
  source = "./modules/cloud_sql"

  region = var.region
  cloudsql_instance_name = var.cloudsql_instance_name
  cloudsql_database_name = var.cloudsql_database_name
  cloud_run_sa_email = module.iam.cloud_run_sa_email
}
