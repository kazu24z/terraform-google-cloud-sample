terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  # 状態ファイルの保存先
  backend "gcs" {
    bucket = "svelte-app-demo-455307-terraform"
    prefix = ""
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
