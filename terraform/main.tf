terraform {
  required_version = ">= 1.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    encrypt = true
    bucket  = var.s3_backend_bucket
    key     = var.backend_state_key
    region  = var.region
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}