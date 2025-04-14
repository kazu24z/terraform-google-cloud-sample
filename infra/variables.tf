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

variable "artifact_registry_image_name" {
  description = "コンテナイメージ名"
  type = string
}

variable "cloud_run_service_name" {
  description = "Cloud Runサービス名"
  type = string
}

variable "cloudsql_instance_name" {
  description = "Cloud SQLインスタンス名"
  type = string
}

variable "cloudsql_database_name" {
  description = "Cloud SQLデータベース名"
  type = string
}

variable "terraform_state_bucket_name" {
  description = "Terraform State用バケット名"
  type = string
}
