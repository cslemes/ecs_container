resource "aws_security_group" "aurora_sg" {
  name        = "aurora_security_group"
  description = "Security group for Aurora Serverless"
  vpc_id      = aws_vpc.main.id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "databricks_sg" {
  name        = "databricks_security_group"
  description = "Security group for Databricks workspace"
  vpc_id      = aws_vpc.main.id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
