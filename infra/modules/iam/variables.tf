variable "project_id" {
  description = "GCPプロジェクトID"
}

variable "region" {
  description = "デプロイするリージョン"
}

variable "cloud_run_service_name" {
  description = "Cloud Runサービス名"
}

variable "artifact_registry_image_name" {
  description = "コンテナイメージ名"
}

variable "artifact_registry_repository_name" {
  description = "Artifact Registryリポジトリ名"
}

variable "cloudsql_instance_name" {
  description = "Cloud SQLインスタンス名"
}

variable "terraform_state_bucket_name" {
  description = "Terraform State用バケット名"
}
