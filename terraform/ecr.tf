resource "aws_ecr_repository" "my_app_repo" {
  name                 = "ecs_repository"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
