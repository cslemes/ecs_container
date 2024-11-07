resource "aws_ecs_service" "vitess" {
  name            = "vitess-service-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.vitess.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups  = [aws_security_group.vitess.id]
    assign_public_ip = true
  }
}
