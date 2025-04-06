resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-sa"
  display_name = "Cloud Run Service Account"
  description  = "サービスアカウントfor Cloud RunとCloud SQL"
}

resource "google_project_iam_member" "instance_user" {
  project = var.project_id
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}
resource "google_project_iam_member" "secret_accessor" {
  project = var.project_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}
