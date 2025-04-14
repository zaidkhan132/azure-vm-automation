output "tfstate_complete_url" {
  description = "Complete URL of the tfstate file in Azure Blob Storage"
  value       = "https://${var.backend_sa}.blob.core.windows.net/${var.backend_container}/${var.env_name}-tfstate"
}
