resource "google_secret_manager_secret" "database_url" {
  secret_id = "DATABASE_URL"
  replication {
    auto {}  # 現在の設定に合わせる
  }
}
