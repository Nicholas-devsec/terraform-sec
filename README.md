# SECURE TERRAFORM PROJECT

## Overview

This project demonstrates how to securely use Terraform with AWS and HashiCorp Vault. It provisions an EC2 instance, generates an RSA key pair, and securely stores the private key in Vault. The project follows best practices for securing sensitive information, such as using environment variables for credentials and remote backend storage for the Terraform state.

## What You Need

- Terraform installed
- AWS account with IAM permissions to create resources (EC2, Key Pair)
- Vault server (either local or hosted)
- A text editor to modify configuration files

## Key Features

- EC2 Instance Creation: A basic EC2 instance is launched with a key pair generated via Terraform.
- Key Pair Security: The private key is generated using the tls provider and securely stored in Vault.
- Environment Variables: Sensitive variables like AWS credentials and Vault paths are managed via environment variables to maintain security.
- Remote Backend Storage: The Terraform state file is stored remotely using HashiCorp’s Cloud Platform (HCP) to prevent local state file issues, enable state locking, and allow for team collaboration. Commands can be executed locally or via the cloud

## Setup and Usage

### 1. Set Up Environment Variables (Linux/Mac)

For security, sensitive variables like AWS credentials and Vault paths should be set as environment variables. This eliminates the need to hardcode credentials in Terraform files.

Run the following commands in your terminal:

`export AWS_ACCESS_KEY_ID="your-access-key-id`

`export AWS_SECRET_ACCESS_KEY="your-secret-access-key`

`export AWS_SESSION_TOKEN="your-session-token`  # Optional, for temporary credentials

`export TF_VAR_vault_address="http://127.0.0.1:8200` # Replace with your Vault server address

`export TF_VAR_pem_path="secret/ec2-pem-key`           # Path to store the PEM file in Vault

`export TF_VAR_key_pair_name="my-ec2-key-pair`         # Key pair name for EC2

For instructions on setting up environment variables in other operating systems (e.g., Windows), please refer to the relevant documentation or guides.

### 2. Initialize Terraform

Run the following command to initialize the Terraform configuration:

`terraform init`

This will download the necessary providers and set up your working directory.

### 3. Apply the Configuration

Run the following command to apply the configuration and provision the EC2 instance, key pair, and store the private key in Vault:

`terraform apply`

This will prompt you to confirm the plan. Type yes to proceed with the deployment.

### 4. Retrieve the PEM Key

If needed, retrieve the PEM private key from Vault to access your EC2 instance:

`vault kv get -field=private_key secret/ec2-pem-key > ec2-key.pem`
`chmod 400 ec2-key.pem`

### 5. SSH into EC2

Use the PEM file to SSH into your EC2 instance:

`ssh -i ec2-key.pem ec2-user@<instance-public-ip>`

Replace <instance-public-ip> with the public IP address of your EC2 instance, which can be found in the Terraform output or AWS Console.

## Best Security Practices

- Use Environment Variables: Never hardcode sensitive credentials like AWS access keys or Vault paths in configuration files. Always use environment variables to securely manage these.
- Remote Backend: Store the Terraform state file in a remote backend (such as HCP) to prevent issues with local state files and enable team collaboration.
- Key Rotation: Rotate your AWS and Vault credentials regularly for added security.
- Minimal IAM Permissions: Ensure that the AWS IAM credentials used by Terraform have the least privilege—only grant access to the necessary services.
