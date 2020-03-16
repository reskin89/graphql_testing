data "aws_iam_policy_document" "ExecutionPolicy" {
  statement {
    sid = "1"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "LambdaExecutionPolicy" {
  description = "Basic Lambda Execution Role"
  path        = "/"
  policy      = "${data.aws_iam_policy_document.ExecutionPolicy.json}"
}

resource "aws_iam_role" "LamdbaExecutionRole" {
  name = "LambdaExecutionRoleAPIGateway"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = "${local.global_tags}"
}

resource "aws_ssm_parameter" "ExecutionARN" {
  name  = "/dev/ExecutionRoleARN"
  type  = "String"
  value = "${aws_iam_role.LamdbaExecutionRole.arn}"
}

##################
# Cognito Things #
##################
# resource "aws_iam_role" "CognitoUserRole" {
#   name = "Cognito_User_Role_${var.env}"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRoleWithWebIdentity",
#       "Principal": {
#         "Federated": "cognito-identity.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Condition": {
#         "ForAnyValue:StringLike": {
#           "cognito-identity.amazonaws.com:amr": "authenticated"
#         }
#       },
#       "Sid": ""
#     }
#   ]
# }
# EOF

#   tags = "${local.global_tags}"
# }

# data "aws_iam_policy_document" "CognitoAuth" {
#   statement {
#     sid = "1"

#     actions = [
#       "apigateway:POST",
#       "apigateway:PATCH",
#     ]

#     resources = [
#       "arn:aws:apigateway:*::/restapis/*/authorizers"
#     ]

#     condition {
#       test = "ArnLike"
#       variable = "apigateway:CognitoUserPoolProviderArn"

#       values = [
#         "${aws_cognito_user_pool.webauthorizer.arn}"
#       ]
#     }
#   }
# }
