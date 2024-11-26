# Provider Configuration
provider "vault" {
  address = var.vault_address
}

provider "aws" {
  region = var.aws_region
}

# Generate a Key Pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Store the Private Key in Vault
resource "vault_generic_secret" "pem_file" {
  path      = var.pem_path
  data_json = jsonencode({
    private_key = tls_private_key.ec2_key.private_key_pem
  })
}

# Retrieve the Private Key from Vault (if needed for other uses)
data "vault_generic_secret" "retrieved_pem" {
  path = var.pem_path
}

# Create the Key Pair in AWS using the Public Key
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# AWS EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-12345678" # Replace with a valid AMI
  instance_type = "t2.micro"

  key_name = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "SecureInstance"
  }
}
