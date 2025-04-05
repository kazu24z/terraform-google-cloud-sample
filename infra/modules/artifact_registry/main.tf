
resource "google_artifact_registry_repository" "app_repo" {
  location      = var.region
  repository_id = var.artifact_registry_repository_name
  format        = "DOCKER"
}
