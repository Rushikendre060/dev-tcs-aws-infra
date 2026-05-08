terraform {
  backend "s3" {
    bucket = "terraform-state-apr-2026-rk"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
