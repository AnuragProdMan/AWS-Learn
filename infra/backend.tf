terraform {
  backend "s3" {
    bucket = "my-tf-state-anurag"
    key = "springboot-app/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "tf-lock-table"
    encrypt = true
  }
}