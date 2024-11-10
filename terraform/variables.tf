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

variable "secret_name" {
  type = string

}

variable "aws_account_id" {
  type = string

}

variable "environment" {
  type = string
}
