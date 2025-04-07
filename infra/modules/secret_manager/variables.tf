variable "database_connection_string" {
  description = "The full database connection string."
  type        = string
  sensitive   = true # 接続文字列にはパスワードが含まれるため機密扱い
}

