provider "aws" {
  region = "us-east-2"
}

provider "databricks" {
  alias         = "mws"
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.56.0"
    }
  }

  backend "s3" {
    bucket = "bucket1-cslemes"
    key    = "ecs/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "databricks" {
  alias = "workspace"
  host  = databricks_mws_workspaces.this.workspace_url
  token = databricks_mws_workspaces.this.token[0].token_value
}

