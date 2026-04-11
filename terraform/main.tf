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
    bucket  = "terraform-state-bucket-917675236035-ap-southeast-2-an"
    key     = "terraform.tfstate"
    region  = "ap-southeast-2"
  }
}

provider "aws" {
  region  = "ap-southeast-2"
  profile = "default"
}