# Cloud Map Namespace

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "local"
  description = "private dns namespace for services"
  vpc         = aws_vpc.main.id
}

# Cloud Map Service
resource "aws_service_discovery_service" "ecs_service_discovery" {
  name         = "ecs-service-discovery"
  namespace_id = aws_service_discovery_private_dns_namespace.this.id

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.this.id
    routing_policy = "MULTIVALUE"

    dns_records {
      type = "A"
      ttl  = 60
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
