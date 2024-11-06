# resource "aws_ssm_parameter" "aurora_endpoint" {
#   name  = format("/%s/aurora/endpoint", var.project_name)
#   type  = "String"
#   value = aws_rds_cluster.aurora_cluster.endpoint
# }

resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/vpc/vpc_id", var.project_name)
  type  = "String"
  value = aws_vpc.main.id
}

resource "aws_ssm_parameter" "private_1" {
  name  = format("/%s/vpc/subnet_private_1", var.project_name)
  type  = "String"
  value = aws_subnet.private_subnet_1.id
}

resource "aws_ssm_parameter" "private_2" {
  name  = format("/%s/vpc/subnet_private_2", var.project_name)
  type  = "String"
  value = aws_subnet.private_subnet_2.id
}


resource "aws_ssm_parameter" "public_1" {
  name  = format("/%s/vpc/subnet_public_1", var.project_name)
  type  = "String"
  value = aws_subnet.public_subnet_1.id
}

resource "aws_ssm_parameter" "public_2" {
  name  = format("/%s/vpc/subnet_public_2", var.project_name)
  type  = "String"
  value = aws_subnet.public_subnet_2.id
}

resource "aws_ssm_parameter" "aws_security_group" {
  name  = format("/%s/vpc/security_group", var.project_name)
  type  = "String"
  value = aws_security_group.main.id

}

resource "aws_ssm_parameter" "cluster_name" {
  name  = format("/%s/ecs/cluster_name", var.project_name)
  type  = "String"
  value = aws_ecs_cluster.lab-ecs.name
}


resource "aws_ssm_parameter" "cluster_id" {
  name  = format("/%s/ecs/cluster_id", var.project_name)
  type  = "String"
  value = aws_ecs_cluster.lab-ecs.id
}

resource "aws_ssm_parameter" "cluster_arn" {
  name  = format("/%s/ecs/cluster_arn", var.project_name)
  type  = "String"
  value = aws_ecs_cluster.lab-ecs.arn
}

resource "aws_ssm_parameter" "ecsTaskExecutionRole" {
  name  = format("/%s/ecs/ecsTaskExecutionRole", var.project_name)
  type  = "String"
  value = aws_iam_role.ecs_task_execution_role.arn
}

