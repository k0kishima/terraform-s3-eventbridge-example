resource "aws_cloudwatch_event_rule" "s3_put_event" {
  name        = "s3-put-event-rule"
  description = "Trigger on file upload to S3 bucket"

  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : [aws_s3_bucket.event_receiver_bucket.bucket]
      },
      "object" : {
        "key" : [{
          "prefix" : "data/"
        }]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.s3_put_event.name
  target_id = "LambdaTarget"
  arn       = aws_lambda_function.event_processor.arn
}
