resource "aws_s3_bucket" "application_lambdas" {
  bucket = "eskin-graphql-app-lambdas"
  acl = "private"

  tags = "${local.global_tags}"

  versioning {
    enabled = true
  }
}
