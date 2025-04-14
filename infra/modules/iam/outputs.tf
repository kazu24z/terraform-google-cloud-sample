output "cloud_run_sa_email" {
  value = google_service_account.cloud_run_sa.email
}

output "github_actions_infra_sa" {
  value = google_service_account.github_actions_infra_sa
}
