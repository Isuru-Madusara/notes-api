terraform {
  backend "s3" {
    bucket       = "notes-api-tfstate-248262247864"
    key          = "notes-api/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
