# resource "aws_ssm_parameter" "aurora_endpoint" {
#   name  = "/${var.project_name}/aurora/endpoint"
#   type  = "String"
#   value = aws_rds_cluster.aurora_cluster.endpoint
# }

resource "aws_ssm_parameter" "vpc" {
  name  = "/${var.project_name}/vpc/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
}

resource "aws_ssm_parameter" "private_1" {
  name  = "/${var.project_name}/vpc/subnet_private_1"
  type  = "String"
  value = aws_subnet.private_subnet_1.id
}

resource "aws_ssm_parameter" "private_2" {
  name  = "/${var.project_name}/vpc/subnet_private_2"
  type  = "String"
  value = aws_subnet.private_subnet_2.id
}


resource "aws_ssm_parameter" "public_1" {
  name  = "/${var.project_name}/vpc/subnet_public_1"
  type  = "String"
  value = aws_subnet.public_subnet_1.id
}

resource "aws_ssm_parameter" "public_2" {
  name  = "/${var.project_name}/vpc/subnet_public_2"
  type  = "String"
  value = aws_subnet.public_subnet_2.id
}

resource "aws_ssm_parameter" "aws_security_group" {
  name  = "/${var.project_name}/vpc/security_group"
  type  = "String"
  value = aws_security_group.main.id

}

resource "aws_ssm_parameter" "cluster_name" {
  name  = "/${var.project_name}/ecs/cluster_name"
  type  = "String"
  value = aws_ecs_cluster.ecs_cluster.name
}


resource "aws_ssm_parameter" "cluster_id" {
  name  = "/${var.project_name}/ecs/cluster_id"
  type  = "String"
  value = aws_ecs_cluster.ecs_cluster.id
}

resource "aws_ssm_parameter" "cluster_arn" {
  name  = "/${var.project_name}/ecs/cluster_arn"
  type  = "String"
  value = aws_ecs_cluster.ecs_cluster.arn
}

resource "aws_ssm_parameter" "ecsTaskExecutionRole" {
  name  = "/${var.project_name}/ecs/ecsTaskExecutionRole"
  type  = "String"
  value = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ssm_parameter" "service_discovery_namespace" {
  name  = "/${var.project_name}/ecs/service_discovery_namespace"
  type  = "String"
  value = aws_service_discovery_private_dns_namespace.this.arn
}

resource "aws_ssm_parameter" "aws_service_discovery_service" {
  name  = "/${var.project_name}/ecs/service_discovery_service"
  type  = "String"
  value = aws_service_discovery_service.ecs_service_discovery.arn

}

resource "aws_ssm_parameter" "ecs_task_role" {
  name  = "/${var.project_name}/ecs/ecs_task_role"
  type  = "String"
  value = aws_iam_role.ecs_task_role.arn

}

resource "aws_ssm_parameter" "region" {
  name  = format("/${var.project_name}/region")
  type  = "String"
  value = var.aws_region
}

resource "aws_ssm_parameter" "mysql_secret" {
  name  = format("/${var.project_name}/mysql_secret")
  type  = "String"
  value = aws_secretsmanager_secret.mysql_secret.arn
}
