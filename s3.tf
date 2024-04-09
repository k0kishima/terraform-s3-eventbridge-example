resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "event_receiver_bucket" {
  provider = aws.primary
  bucket   = "enterprises-fuji-handson-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.event_receiver_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.event_receiver_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_notification" "this" {
  bucket      = aws_s3_bucket.event_receiver_bucket.id
  eventbridge = true
}
