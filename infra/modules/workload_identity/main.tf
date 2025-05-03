locals {
  github_repo_owner   = "kazu24z"
  github_repo_name    = "terraform-google-cloud-sample"
  workload_identity_pool_id = "github-actions"
  workload_identity_pool_provider_id = "github-actions-provider"
}

resource "google_iam_workload_identity_pool" "main" {
  project      = var.project_id
  workload_identity_pool_id = local.workload_identity_pool_id
  display_name = "GitHub Actions Pool"
  description  = "GitHub Actions からのアクセスを許可する Workload Identity Pool"
}

resource "google_iam_workload_identity_pool_provider" "main" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
  workload_identity_pool_provider_id = local.workload_identity_pool_provider_id
  display_name                       = "GitHub Provide"
  description                        = "GitHub Actions identity pool provider for automated test"
  attribute_condition                = "assertion.repository == \"${local.github_repo_owner}/${local.github_repo_name}\""
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "workload_identity_user_infra" {
  service_account_id = var.service_account_infra.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.main.workload_identity_pool_id}/attribute.repository/${local.github_repo_owner}/${local.github_repo_name}"
}

resource "google_service_account_iam_member" "workload_identity_user_app" {
  service_account_id = var.service_account_app.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.main.workload_identity_pool_id}/attribute.repository/${local.github_repo_owner}/${local.github_repo_name}"
}
