terraform {
  backend "s3" {
    bucket = "eskin-tf-remote-state"
    key    = "graphql-api-tf-state"
    region = "us-east-1"
  }
}

variable "env" {
  description = "environment"
}

variable "global_tags" {
  type = map(string)

  default = {
    "CreatedBy" = "Terraform: reskin89/graphql_testing"
    "Purpose" = "AWS Development"
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