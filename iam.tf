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
  path = "/"
  policy = "${data.aws_iam_policy_document.ExecutionPolicy.json}"
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
  name = "/dev/ExecutionRoleARN"
  type = "String"
  value = "${aws_iam_role.LamdbaExecutionRole.arn}"
}