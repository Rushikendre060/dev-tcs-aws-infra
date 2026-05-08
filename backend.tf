terraform {
  backend "s3" {
    bucket = "terraform-state-dec-2025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
