# gen-ai

A lightweight AWS Bedrock RAG project that deploys a Bedrock knowledge base backed by S3, with a Lambda ingestion trigger and a local query script.

## Project Overview

This repository includes:
- `terraform/` — Infrastructure as code for AWS resources: Bedrock Knowledge Base, S3 bucket, Lambda ingestion trigger, IAM roles, and notifications.
- `lambda/ingest/handler.py` — AWS Lambda function that starts Bedrock ingestion jobs for new S3 documents.
- `rag_query.py` — Local CLI script that queries the Bedrock knowledge base using the Bedrock Agent runtime.

## Architecture

1. Documents are uploaded to the S3 bucket under the `docs/` prefix.
2. S3 object creation triggers the Lambda function.
3. Lambda calls Bedrock Agent to start an ingestion job for the configured knowledge base and data source.
4. `rag_query.py` queries the knowledge base with a user prompt and prints the generated response.

## Prerequisites

- Python 3.11+
- Terraform 1.14.8+
- AWS CLI configured with credentials and a profile that has permissions for Bedrock, S3, Lambda, IAM, and related resources
- AWS account with Bedrock access

## Usage

### Upload documents for ingestion

Upload files to the S3 bucket created by Terraform using the `docs/` prefix. For example:

```bash
aws s3 cp my-file.pdf s3://<bucket-name>/docs/my-file.pdf
```

The S3 notification will trigger the Lambda function and start an ingestion job for Bedrock.

### Query the knowledge base

Run the local query script with a prompt and the knowledge base ID:

```bash
python rag_query.py --query "What is the status of the ingestion?" --kb-id <knowledge-base-id>
```

The script uses `bedrock-agent-runtime` and the Claude 3 Sonnet model ARN configured in the code.

## Files

- `rag_query.py` — CLI query tool for the Bedrock knowledge base.
- `lambda/ingest/handler.py` — Lambda handler that starts Bedrock ingestion jobs.
- `terraform/main.tf` — AWS provider configuration and Terraform backend.
- `terraform/bedrock.tf` — Bedrock knowledge base and Bedrock IAM role/policy.
- `terraform/s3.tf` — S3 bucket, notification, and Lambda permission resources.
- `terraform/lambda.tf` — Lambda function and its IAM policy.
- `terraform/variables.tf` — Default Terraform variables.
- `terraform/outputs.tf` — Terraform outputs for bucket and role.

## Notes

- The Terraform AWS provider is configured for `ap-southeast-2` by default.
- The remote state backend is defined in `terraform/main.tf` using an S3 bucket.
- The knowledge base ID is not currently exported by Terraform, so you may need to retrieve it from the AWS console or extend Terraform outputs.
- Update the model ARN in `rag_query.py` if you want to use a different Bedrock foundation model.

## Future Improvements
