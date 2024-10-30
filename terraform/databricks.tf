data "databricks_aws_unity_catalog_assume_role_policy" "this" {
  aws_account_id = data.aws_caller_identity.current.account_id
  role_name      = local.uc_iam_role
  external_id    = databricks_storage_credential.external.aws_iam_role[0].external_id
}

data "databricks_aws_unity_catalog_policy" "this" {
  aws_account_id = data.aws_caller_identity.current.account_id
  bucket_name    = aws_s3_bucket.external.id
  role_name      = local.uc_iam_role
}





# Create a Databricks workspace using the cross-account IAM role
resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.aws_region
  workspace_name = local.prefix

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id

  token {
    comment = "Terraform"
  }
}



# Create a Databricks cluster with serverless compute in the workspace
resource "databricks_cluster" "db_cluster" {
  provider   = databricks.workspace
  depends_on = [databricks_mws_workspaces.this]

  cluster_name            = "my-databricks-cluster"
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = 20

  node_type_id = data.databricks_node_type.smallest.id

  autoscale {
    min_workers = 1
    max_workers = 2
  }
}

