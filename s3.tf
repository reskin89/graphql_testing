resource "aws_s3_bucket" "application_lambdas" {
  bucket = "eskin-app-lambdas-${var.env}"
  acl    = "private"

  tags = "${local.global_tags}"

  versioning {
    enabled = true
  }
}
