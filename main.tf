terraform {
  backend "s3" {
    bucket = "eskin-dev-tf-remote-state"
    key    = "graphql-api-tf-state"
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  global_tags = merge(
    var.global_tags,
    {
      "Env" = var.env
    }
  )
}