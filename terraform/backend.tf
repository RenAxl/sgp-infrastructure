terraform {
  backend "s3" {
    bucket         = "sgp-terraform-state-sgpx921"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "sgp-terraform-state-lock-table"
  }
}
 