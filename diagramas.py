from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import ECS
from diagrams.aws.database import Aurora, DMS
from diagrams.aws.storage import S3
from diagrams.aws.network import ALB, VPC, PrivateSubnet
from diagrams.aws.network import Privatelink
from diagrams.aws.general import User
from diagrams.azure.analytics import Databricks

with Diagram("AWS ECS Fargate Architecture with Aurora and Databricks", show=False):
    user = User("Client")
    Databricks = Databricks("Databricks Paas")

    with Cluster("AWS Cloud"):
        vpc = VPC("VPC")

        with Cluster("Public Subnet"):
            alb = ALB("Application Load Balancer")

        with Cluster("Private Subnet"):
            with Cluster("ECS Fargate Cluster"):
                fargate_task1 = ECS("Web app")
                fargate_task2 = ECS("API 1")
                fargate_task3 = ECS("API 2")
                fargate_task4 = ECS("API 3")
                fargate_task5 = ECS("API 4")
                fargate_task6 = ECS("API 5")

            # Aurora MySQL Database
            aurora_db = Aurora("Aurora MySQL")

            # Database Migration Service
            dms = DMS("DMS")

            # S3 Storage
            s3 = S3("Datalake Raw")

            # PrivateLink to Databricks
            databricks = Privatelink("Databricks Link")

    # Connections
    user >> alb >> [fargate_task1]
    fargate_task1 >> aurora_db
    fargate_task2 >> aurora_db
    fargate_task3 >> aurora_db
    fargate_task4 >> aurora_db
    fargate_task5 >> aurora_db
    fargate_task6 >> aurora_db
    aurora_db >> dms
    dms >> s3 >> databricks >> Databricks
    
