resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "local"
  description = "private dns namespace for services"
  vpc         = aws_vpc.main.id
}
