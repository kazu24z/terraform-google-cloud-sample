
variable "region" {
  description = "デプロイするリージョン"
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

variable "cloud_run_sa_email" {
  description = "Cloud Runサービスアカウントのメールアドレス"
  type = string
}
