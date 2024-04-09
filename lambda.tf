resource "aws_lambda_function" "event_processor" {
  function_name = "event-processor"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  filename      = "lambda_function.zip"
}
