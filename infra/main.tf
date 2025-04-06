module "api" {
  source = "./modules/api"
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  region = var.region
  artifact_registry_repository_name = var.artifact_registry_repository_name
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
}
