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

resource "databricks_external_location" "some" {
  provider        = databricks.workspace
  name            = "external"
  url             = "s3://${aws_s3_bucket.external.id}/some"
  credential_name = databricks_storage_credential.external.id
}

resource "databricks_grants" "some" {
  provider          = databricks.workspace
  external_location = databricks_external_location.some.id
  grant {
    principal  = "Data Engineers"
    privileges = ["CREATE_EXTERNAL_TABLE", "READ_FILES"]
  }
}

# metastore
resource "databricks_metastore" "this" {
  provider      = databricks.mws
  name          = "primary"
  region        = var.aws_region
  force_destroy = true
}

resource "databricks_metastore_assignment" "default_metastore" {
  provider             = databricks.mws
  workspace_id         = databricks_mws_workspaces.this.workspace_id
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}

# Create Unity Catalog objects in the metastore
resource "databricks_catalog" "sandbox" {
  provider     = databricks.workspace
  storage_root = "s3://${aws_s3_bucket.root_storage_bucket.bucket}/some"
  name         = "sandbox"
  comment      = "this catalog is managed by terraform"
  properties = {
    purpose = "testing"
  }
  depends_on = [databricks_metastore_assignment.default_metastore]
}

resource "databricks_grants" "sandbox" {
  provider = databricks.workspace
  catalog  = databricks_catalog.sandbox.name
  grant {
    principal  = "Data Scientists"
    privileges = ["USE_CATALOG", "CREATE"]
  }
  grant {
    principal  = "Data Engineers"
    privileges = ["USE_CATALOG"]
  }
}

resource "databricks_schema" "things" {
  provider     = databricks.workspace
  catalog_name = databricks_catalog.sandbox.id
  name         = "things"
  comment      = "this database is managed by terraform"
  properties = {
    kind = "various"
  }
}

resource "databricks_grants" "things" {
  provider = databricks.workspace
  schema   = databricks_schema.things.id
  grant {
    principal  = "Data Engineers"
    privileges = ["USE_SCHEMA"]
  }
}
