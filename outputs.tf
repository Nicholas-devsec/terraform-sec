output "pem_file_path" {
  description = "The Vault path for the PEM file"
  value       = vault_generic_secret.pem_file.path
}
