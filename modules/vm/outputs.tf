output "vm_public_ip" {
  description = "Public IP address of the deployed VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}
