resource "aws_cognito_user_pool" "webauthorizer" {
  name = "api_gateway_users_${var.env}"
}

resource "aws_cognito_resource_server" "webauthorizer" {
  identifier = "https://${var.env}-api.ryaneskin.com"
  name       = "Dev Authorizer"

  user_pool_id = "${aws_cognito_user_pool.webauthorizer.id}"

  depends_on = ["aws_cognito_user_pool.webauthorizer"]

  scope {
    scope_name        = "myip.get"
    scope_description = "scope for grabbing an IP"
  }
}

resource "aws_ssm_parameter" "userPoolArn" {
  name  = "/${var.env}/userpoolArn"
  type  = "String"
  value = "${aws_cognito_user_pool.webauthorizer.arn}"
}