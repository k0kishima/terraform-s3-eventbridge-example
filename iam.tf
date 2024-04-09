resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "s3_trigger_tutorial" {
  name        = "s3-trigger-tutorial"
  description = "Policy for Lambda function to access logs and S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
        ],
        Resource = "arn:aws:logs:*:*:*",
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
        ],
        Resource = "arn:aws:s3:::*/*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "s3_trigger_tutorial_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.s3_trigger_tutorial.arn
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
