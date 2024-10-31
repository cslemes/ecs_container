output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "cluster_name" {
  value = aws_ecs_cluster.lab-ecs.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.lab-ecs.arn
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "databricks_cluster_id" {
  value = databricks_cluster.db_cluster.id
}

output "databricks_workspace_id" {
  value = databricks_mws_workspaces.this.workspace_id
}

output "databricks_iam_role_arn" {
  value = aws_iam_role.cross_account_role.arn
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_app_repo.repository_url
}

output "ecr_repository_name" {
  value = aws_ecr_repository.my_app_repo.name
}

