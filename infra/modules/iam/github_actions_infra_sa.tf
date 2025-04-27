# ロールのリスト
locals {
    roles = tolist([
        "roles/editor",
        "roles/iam.serviceAccountTokenCreator"
    ])
}


# ==== サービスアカウント定義 ====
resource "google_service_account" "github_actions_infra_sa" {
  account_id   = "github-actions-infra-sa"
  display_name = "GitHub Actions Infra Service Account"
  description  = "サービスアカウントfor GitHub Actions Infra"
}

# ==== プロジェクトレベルのIAMポリシー ====
resource "google_project_iam_member" "project_level_roles" {
  for_each = toset(local.roles) # local.roles のリストをセットに変換してループ

  project = var.project_id
  role    = each.value # ループ中の各ロールを割り当て
  member  = "serviceAccount:${google_service_account.github_actions_infra_sa.email}"
}

# ==== リソースレベルのIAMポリシー ====

# Terraform State用バケットのオブジェクトユーザー
resource "google_storage_bucket_iam_member" "terraform_state_admin" {
  bucket = var.terraform_state_bucket_name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.github_actions_infra_sa.email}"
}

# サービス アカウント ユーザー

# Cloud Runサービスアカウントとして動作する権限
resource "google_service_account_iam_member" "cloud_run_sa_user" {
  service_account_id = google_service_account.cloud_run_sa.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.github_actions_infra_sa.email}"
}
