resource "aws_s3_bucket" "event_receiver_bucket" {
  bucket = "enterprises-fuji-handson-${random_id.suffix.hex}"
  acl    = "private"
}

resource "aws_s3_bucket_notification" "event_receiver_bucket_notification" {
  bucket      = aws_s3_bucket.event_receiver_bucket.id
  eventbridge = true
}
