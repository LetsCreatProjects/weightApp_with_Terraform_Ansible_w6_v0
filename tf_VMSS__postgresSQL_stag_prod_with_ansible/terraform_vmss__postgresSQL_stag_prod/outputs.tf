/*----------------------------------------------------------------------------------------*/
#  output
/*----------------------------------------------------------------------------------------*/

output "VMSS_Password" {
  value =module.Scale_set_module.password
  sensitive = true
}


output "public_ip_addr_id" {
  value = azurerm_public_ip.LoadBalacerPublicIp.ip_address
  # sensitive = true
}