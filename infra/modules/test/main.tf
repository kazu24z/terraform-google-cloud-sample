locals {
  bucket_name_test = "test_bucket3"
}

resource "google_storage_bucket" "terraform_state" {
  name     = local.bucket_name_test
  location = "asia-northeast1"
  versioning {
    enabled = false
  }
}
