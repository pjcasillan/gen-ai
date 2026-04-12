output "bucket_name" {
  value = aws_s3_bucket.docs.bucket
}

output "role_arn" {
  value = aws_iam_role.bedrock_role.arn
}