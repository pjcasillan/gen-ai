import argparse
import boto3

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--query", help="The query to ask the knowledge base")
    parser.add_argument("--kb-id", help="The knowledge base ID to query")
    args = parser.parse_args()

    client = boto3.client("bedrock-agent-runtime")

    response = client.retrieve_and_generate(
        input={
            "text": args.query
        },
        retrieveAndGenerateConfiguration={
            "type": "KNOWLEDGE_BASE",
            "knowledgeBaseConfiguration": {
                "knowledgeBaseId": args.kb_id,
                "modelArn": "arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0"
            }
        }
    )

    print(response["output"]["text"])

if __name__ == "__main__":    
    main()