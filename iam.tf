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

resource "aws_iam_policy" "LambdaExecutionRole" {
  description = "Basic Lambda Execution Role"
  path = "/"
  policy = "${data.aws_iam_policy_document.ExecutionPolicy.json}"
}

resource "aws_ssm_parameter" "ExecutionARN" {
  name = "/dev/ExecutionRoleARN"
  type = "String"
  value = "${aws_iam_policy.LambdaExecutionRole.arn}"
}