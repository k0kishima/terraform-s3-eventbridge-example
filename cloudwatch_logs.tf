resource "aws_cloudwatch_log_group" "s3_put_event_log_group" {
  name = "/aws/events/s3-put-event"
}
