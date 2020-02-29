terraform {
  backend "s3" {
    bucket = "eskin-dev-tf-remote-state"
    key    = "graphql-api-tf-state"
    region = "us-east-1"
  }
}

locals {
  global_tags = merge(
    var.global_tags,
    {
      "Env" = var.env
    }
  )
}