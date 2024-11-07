# ECS Container Infrastructure with Terraform

This project provides a Terraform-based setup to deploy a containerized application on AWS ECS. It includes scripts to create and configure essential AWS resources, and a GitHub Actions workflow to automate deployment.

## Table of Contents
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Fork the Repository](#fork-the-repository)
  - [Configure Secrets and Variables](#configure-secrets-and-variables)
  - [Run GitHub Actions Workflow](#run-github-actions-workflow)
- [File Descriptions](#file-descriptions)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

The main files and directories in this repository are:

- **ecs.tf**: Configures the ECS cluster where containers will run.
- **iam.tf**: Sets up IAM roles and permissions for ECS and other resources.
- **internet_gateway.tf**: Creates an Internet Gateway for network access.
- **nat_gateway.tf**: Sets up a NAT Gateway for private subnet access to the internet.
- **outputs.tf**: Defines output values that Terraform will display, like resource IDs or URLs.
- **parameters.tf**: Stores reusable parameters for modular configuration.
- **private_subnets.tf**: Configures private subnets, isolating them from direct internet access.
- **providers.tf**: Specifies the cloud provider configuration (AWS).
- **public_subnets.tf**: Configures public subnets with internet access.
- **service_discovery.tf**: Enables service discovery for ECS services.
- **sg.tf**: Configures Security Groups to control inbound and outbound traffic.
- **terraform.tfvars**: Holds variable values specific to this setup, like region and environment configurations.
- **variables.tf**: Declares variables for easy configuration and reuse across resources.
- **.github/workflows/deploy_infra.yaml**: GitHub Actions workflow file to deploy the infrastructure using Terraform.

## Prerequisites

- **Terraform**: Ensure that Terraform is installed (version 1.9.8 recommended).
- **AWS Account**: You'll need AWS credentials with permissions to create and manage ECS resources.
- **GitHub Account**: Required to fork the repository and set up GitHub Actions.

## Getting Started

### Fork the Repository

1. Fork this repository to your GitHub account by clicking the "Fork" button at the top-right of this page.
2. Clone the forked repository to your local machine:

   ```bash
   git clone https://github.com/<your-username>/ecs_container.git
   cd ecs_container
   ```

### Configure Secrets and Variables

To allow GitHub Actions to deploy your infrastructure, add the following secrets and variables in your repository settings:

1. Go to **Settings** > **Secrets and variables** > **Actions**.
2. Add the following **Secrets**:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
3. Add the following **Variables**:
   - `AWS_REGION`: The AWS region where resources will be deployed (e.g., `us-east-1`).
   - `PROJECT_NAME`: A name for the project to identify resources.
   - `BUCKET_NAME`: S3 bucket name for Terraform state storage (if using remote state).

### Run GitHub Actions Workflow

To deploy the infrastructure, follow these steps:

1. Go to the **Actions** tab in your GitHub repository.
2. Select the **Terraform Deploy** workflow and click **Run workflow**.
3. Choose one of the available deployment types:
   - **plan**: To view a plan of the infrastructure changes.
   - **apply**: To create or update infrastructure.
   - **destroy**: To remove infrastructure.

GitHub Actions will execute the Terraform commands based on the deployment type selected.

## File Descriptions

Each Terraform file serves a specific purpose:

- **ecs.tf**: Configures the ECS cluster.
- **iam.tf**: Sets up necessary IAM roles and permissions.
- **internet_gateway.tf** & **nat_gateway.tf**: Configure gateways for internet access.
- **private_subnets.tf** & **public_subnets.tf**: Define private and public subnets.
- **sg.tf**: Configures security groups to manage traffic.
- **service_discovery.tf**: Enables service discovery for container services.
- **variables.tf** & **terraform.tfvars**: Define and store variables for modular setup.

## Contributing

If you'd like to contribute, please fork the repository and make changes as you'd like. Pull requests are welcome.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This README gives an overview of the project structure, setup steps, and instructions for running the workflow.
