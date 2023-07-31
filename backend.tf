terraform {
  backend "s3" {
    bucket = "terraform-state-vcp-study"
    region = "us-east-1"
    key    = "terraform.tfstate"
  }

}