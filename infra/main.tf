module "api" {
  source = "./modules/api"
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  region = var.region
  artifact_registry_repository_name = var.artifact_registry_repository_name
}
