locals {
  bucket_name_test = "test_bucket5"
}

resource "google_storage_bucket" "terraform_state" {
  name     = local.bucket_name_test
  location = "asia-northeast1"
  versioning {
    enabled = false
  }
}
