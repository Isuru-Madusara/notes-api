resource "aws_cloudwatch_log_group" "app" {
  name              = "/notes-api/app"
  retention_in_days = 7
}

data "aws_iam_policy_document" "ec2_logs" {
  statement {
    sid       = "WriteAppLogs"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.app.arn}:*"]
  }
}

resource "aws_iam_role_policy" "ec2_logs" {
  name   = "notes-api-ec2-logs"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_logs.json
}
