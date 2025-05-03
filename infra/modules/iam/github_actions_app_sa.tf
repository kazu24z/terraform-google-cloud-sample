resource "google_service_account" "github_actions_app_sa" {
  account_id   = "github-actions-app-sa"
  display_name = "GitHub Actions Service Account for App"
  description  = "サービスアカウントfor GitHub Actions"
}

# ==== プロジェクトレベルのIAMポリシー ====

# ==== リソースレベルのIAMポリシー ====
resource "google_artifact_registry_repository_iam_member" "repository_writer" {
  project       = var.project_id
  location      = var.region
  repository    = var.artifact_registry_repository_name
  role          = "roles/artifactregistry.writer"
  member        = "serviceAccount:${google_service_account.github_actions_app_sa.email}"
}

resource "google_artifact_registry_repository_iam_member" "repository_reader" {
  project       = var.project_id
  location      = var.region
  repository    = var.artifact_registry_repository_name
  role          = "roles/artifactregistry.reader"
  member        = "serviceAccount:${google_service_account.github_actions_app_sa.email}"
}

# Cloud Run / Cloud Run Job の実行
resource "google_cloud_run_v2_service_iam_member" "cloud_run_iam" {
  project = var.project_id
  location = var.region
  name = var.cloud_run_service_name
  role = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.github_actions_app_sa.email}"
}

# サービス アカウント ユーザー
resource "google_service_account_iam_member" "service_account_iam" {
  service_account_id = google_service_account.github_actions_app_sa.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.github_actions_app_sa.email}"
}
