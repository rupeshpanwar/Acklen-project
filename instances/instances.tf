data "terraform_remote_state" "network-configuration" {
  config = {
    bucket = var.remote_state_bucket
    key = var.remote_state_key
    region = var.region
  }
  backend = "s3"
}

