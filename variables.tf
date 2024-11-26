variable "vault_address" {
  description = "The Vault server address"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
}

variable "pem_path" {
  description = "The path to store the PEM file in Vault"
  type        = string
}

variable "key_pair_name" {
  description = "The name for the AWS key pair"
  type        = string
}
