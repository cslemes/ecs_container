provider "aws" {
  region = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "bucket1-cslemes"
    key    = "ecs/terraform.tfstate"
    region = "us-east-2"
  }
}

