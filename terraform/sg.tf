resource "aws_security_group" "main" {
  name = format("%s", var.project_name)

  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group_rule" "subnet_ranges" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "ingress"
  description       = "Liberando trafego para a VPC"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_security_group" "vitess" {
  name        = "vitess-sg-${var.project_name}-${var.environment}"
  description = "Security group for Vitess cluster"
  vpc_id      = aws_vpc.main.id

  # etcd
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # vtctld
  ingress {
    from_port   = 15000
    to_port     = 15000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # vttablet
  ingress {
    from_port   = 15100
    to_port     = 16100
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vitess-sg-${var.project_name}-${var.environment}"
  }
}
