variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}


variable "capacity_providers" {
  type = list(any)
  default = [
    "FARGATE", "FARGATE_SPOT"
  ]
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
}

variable "bucket_name" {
  type = string

}

variable "cluster_identifier" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "databricks_client_id" {
  type = string

}

variable "databricks_client_secret" {
  type = string
}

variable "tags" {
  default = {}
}
