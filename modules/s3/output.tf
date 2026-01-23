output "bucket_id" {
  value = aws_s3_bucket.tfstate.id
}
output "bucket_arn" {
  value = aws_s3_bucket.tfstate.arn
}
output "bucket_name" {
  value = aws_s3_bucket.tfstate.bucket
}
