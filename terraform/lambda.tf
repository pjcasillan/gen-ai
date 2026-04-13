resource "aws_lambda_function" "bedrock_ingestion" {
  function_name = "bedrock-ingestion-trigger"
  role          = aws_iam_role.ingestion_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      KNOWLEDGE_BASE_ID = aws_bedrockagent_knowledge_base.kb.id
      DATA_SOURCE_ID    = aws_bedrockagent_data_source.s3_source.data_source_id
    }
  }

  timeout = 60
}

# IAM
resource "aws_iam_role" "ingestion_lambda_role" {
  name = "lambda-ingest-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_ingest_policy" {
  name = "lambda-ingest-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "bedrock:StartIngestionJob",
          "bedrock:GetIngestionJob"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ingestion_policy" {
  role       = aws_iam_role.ingestion_lambda_role.name
  policy_arn = aws_iam_policy.lambda_ingest_policy.arn
}