
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