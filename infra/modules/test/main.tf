locals {
  bucket_name_test = "svelte-app-demo-455307-test_bucket1"
}

resource "google_storage_bucket" "terraform_state" {
  name     = local.bucket_name_test
  location = "asia-northeast1"
  versioning {
    enabled = false
  }
}
