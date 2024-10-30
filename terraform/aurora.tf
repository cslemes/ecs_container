# Create the Aurora Serverless cluster
data "aws_rds_engine_version" "mysql_engine" {
  engine       = "aurora-mysql"
  latest       = true
  default_only = true


  filter {
    name   = "engine-mode"
    values = ["provisioned"]
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = var.cluster_identifier
  database_name      = "auroradb"
  engine             = "aurora-mysql"
  engine_version     = data.aws_rds_engine_version.mysql_engine.id

  engine_mode             = "provisioned"
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 1
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }

  storage_encrypted   = false
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
}


