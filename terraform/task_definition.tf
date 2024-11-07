resource "aws_ecs_task_definition" "vitess" {
  family                   = "vitess-${var.project_name}-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "etcd"
      image = "gcr.io/etcd-development/etcd:v3.4.0"
      command = [
        "/usr/local/bin/etcd",
        "--data-dir=/etcd-data",
        "--name=etcd1",
        "--initial-advertise-peer-urls=http://localhost:2380",
        "--listen-peer-urls=http://0.0.0.0:2380",
        "--advertise-client-urls=http://localhost:2379",
        "--listen-client-urls=http://0.0.0.0:2379",
        "--initial-cluster=etcd1=http://localhost:2380"
      ]
      portMappings = [
        {
          containerPort = 2379
          hostPort      = 2379
        },
        {
          containerPort = 2380
          hostPort      = 2380
        }
      ]
      memory = 512
      cpu    = 256
    },
    {
      name  = "vtctld"
      image = "vitess/vtctld:latest"
      environment = [
        {
          name  = "TOPOLOGY_FLAGS"
          value = "-topo_implementation etcd2 -topo_global_server_address http://localhost:2379 -topo_global_root /vitess/global"
        }
      ]
      portMappings = [
        {
          containerPort = 15000
          hostPort      = 15000
        }
      ]
      memory = 512
      cpu    = 256
      dependsOn = [
        {
          containerName = "etcd"
          condition     = "START"
        }
      ]
    },
    {
      name  = "vttablet"
      image = "vitess/vttablet:latest"
      environment = [
        {
          name  = "TOPOLOGY_FLAGS"
          value = "-topo_implementation etcd2 -topo_global_server_address http://localhost:2379 -topo_global_root /vitess/global"
        }
      ]
      command = [
        "/vt/bin/vttablet",
        "-tablet-path", "zone1-0000000100",
        "-init_keyspace", "test_keyspace",
        "-init_shard", "0",
        "-init_tablet_type", "replica",
        "-port", "15100",
        "-grpc_port", "16100",
        "-service_map", "grpc-queryservice,grpc-tabletmanager,grpc-updatestream",
        "-topology_implementation", "etcd2",
        "-topo_global_server_address", "http://localhost:2379",
        "-topo_global_root", "/vitess/global"
      ]
      portMappings = [
        {
          containerPort = 15100
          hostPort      = 15100
        },
        {
          containerPort = 16100
          hostPort      = 16100
        }
      ]
      memory = 1024
      cpu    = 512
      dependsOn = [
        {
          containerName = "vtctld"
          condition     = "START"
        }
      ]
    }
  ])
}
