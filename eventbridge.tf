resource "aws_cloudwatch_event_rule" "s3_put_event_rule" {
  name = "s3-put-event-rule"
  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : [aws_s3_bucket.event_receiver_bucket.bucket]

      }
    }
  })
}

resource "aws_cloudwatch_event_target" "s3_put_event_target" {
  rule      = aws_cloudwatch_event_rule.s3_put_event_rule.name
  target_id = "s3-trigger-tutorial-target-${random_id.suffix.hex}"
  arn       = aws_cloudwatch_log_group.s3_put_event_log_group.arn
}
