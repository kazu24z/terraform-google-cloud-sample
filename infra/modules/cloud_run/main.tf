resource "google_cloud_run_v2_service" "app" {
  name     = var.cloud_run_service_name
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = var.cloud_run_sa_email
    scaling {
      max_instance_count = 1
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.cloudsql_instance_connection_name]
      }
    }

    containers {
      image = "asia-northeast1-docker.pkg.dev/${var.project_id}/${var.artifact_registry_repository_name}/${var.artifact_registry_image_name}:latest"
      
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
      
      ports {
        container_port = 8080
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
    
  }
}

# Cloud Runの未認証アクセスを許可する（ページの一般公開のため）
resource "google_cloud_run_v2_service_iam_binding" "public_access" {
  project  = var.project_id
  name     = google_cloud_run_v2_service.app.name
  location = google_cloud_run_v2_service.app.location
  role     = "roles/run.invoker"
  members  = ["allUsers"]
}
