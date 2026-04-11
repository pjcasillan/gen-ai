import boto3
import os
import json

client = boto3.client("bedrock-agent")

def lambda_handler(event, context):
    kb_id = os.environ["KNOWLEDGE_BASE_ID"]
    ds_id = os.environ["DATA_SOURCE_ID"]

    response = client.start_ingestion_job(
        knowledgeBaseId=kb_id,
        dataSourceId=ds_id
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Ingestion started",
            "jobId": response["ingestionJob"]["ingestionJobId"]
        })
    }