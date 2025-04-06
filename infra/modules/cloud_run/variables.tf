variable "project_id" {
  description = "GCPプロジェクトID"
  type = string
}

variable "region" {
  description = "デプロイするリージョン"
  type = string
}

variable "cloud_run_service_name" {
  description = "Cloud Runサービス名"
  type = string
}

variable "artifact_registry_image_name" {
  description = "コンテナイメージ名"
  type = string
}

variable "artifact_registry_repository_name" {
  description = "Artifact Registryリポジトリ名"
  type = string
}

variable "cloudsql_instance_connection_name" {
  description = "Cloud SQLインスタンス名"
  type = string
}

variable "cloud_run_sa_email" {
  description = "Cloud Runサービスアカウント名"
  type = string
}

