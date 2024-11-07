output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
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

output "taskrole" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "service_id" {
  value = aws_ecs_service.vitess.id
}
