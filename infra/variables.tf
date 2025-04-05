variable "project_id" {
  description = "GCPプロジェクトID"
  type = string
}

variable "region" {
  description = "デプロイするリージョン"
  type = string
}

variable "artifact_registry_repository_name" {
  description = "Artifact Registryリポジトリ名"
  type = string
}

variable "cloudsql_instance_name" {
  description = "Cloud SQLインスタンス名"
  type = string
}
