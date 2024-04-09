output "bucket_name" {
  value       = aws_s3_bucket.event_receiver_bucket.bucket
  description = "The name of the S3 bucket"
}
