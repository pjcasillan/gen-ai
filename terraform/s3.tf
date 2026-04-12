# AWS Bedrock S3 Bucket
resource "aws_s3_bucket" "docs" {
  bucket = "${var.project_name}-bedrock-docs-${var.region}"
}

resource "aws_s3_bucket_notification" "trigger" {
  bucket = aws_s3_bucket.docs.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.bedrock_ingestion.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "docs/"
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bedrock_ingestion.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.docs.arn
}