terraform {
  backend "s3" {
    bucket = "netflix-clone-2025"
    key    = "tf-state/terraform.tfstate"
    region = "us-east-1"
  }
}
