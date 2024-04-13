resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "event_receiver_bucket" {
  # バケット名の一意性を担保するためにランダムな数値を付与
  bucket = "s3-put-event-example-backet-${random_id.suffix.hex}"
  acl    = "private"
}

resource "aws_s3_bucket_notification" "event_receiver_bucket_notification" {
  bucket      = aws_s3_bucket.event_receiver_bucket.id
  eventbridge = true
}
