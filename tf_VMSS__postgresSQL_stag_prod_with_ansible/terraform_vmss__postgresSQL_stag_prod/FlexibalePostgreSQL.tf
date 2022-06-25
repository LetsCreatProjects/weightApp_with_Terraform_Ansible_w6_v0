/*----------------------------------------------------------------------------------------*/
#  azurerm_private_dns_zone
/*----------------------------------------------------------------------------------------*/
resource "azurerm_private_dns_zone" "Flexibale_Postgres_DataBase_DNS" {
  name                = "Flexible.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.RG.name
  
}
/*----------------------------------------------------------------------------------------*/
#  azurerm_private_dns_zone_virtual_network_link
/*----------------------------------------------------------------------------------------*/
resource "azurerm_private_dns_zone_virtual_network_link" "someTestingWithDnsLink" { #"DNS_Zone_VN_Link" { #"link_to_private_dns_zone" {
  name                  = "someTestingWithDnsLink"#"VnZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.Flexibale_Postgres_DataBase_DNS.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.RG.name

}

/*----------------------------------------------------------------------------------------*/
#  azurerm_postgresql_flexible_server
/*----------------------------------------------------------------------------------------*/
resource "azurerm_postgresql_flexible_server" "PosrgreSQLFlexibleDataServer" {
  name                   = var.dns_postgresSQL #"dbofpostgressqlserverforwebweigthapp"
  resource_group_name    = azurerm_resource_group.RG.name
  location               = azurerm_resource_group.RG.location
  version                = "13" # "12"
  delegated_subnet_id    = azurerm_subnet.Data_Tier.id
  private_dns_zone_id    = azurerm_private_dns_zone.Flexibale_Postgres_DataBase_DNS.id
  administrator_login    = var.pg_user
  administrator_password = var.pg_pass
  zone                   = "1"
  create_mode            = "Default"
  storage_mb             = 32768


  sku_name = "B_Standard_B1ms" #"GP_Standard_D4s_v3"
    
    
    tags = {
    name = var.tags
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.someTestingWithDnsLink] #my edit

}
/*----------------------------------------------------------------------------------------*/
#  azurerm_postgresql_flexible_server_database
/*----------------------------------------------------------------------------------------*/

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "db"
  server_id = azurerm_postgresql_flexible_server.PosrgreSQLFlexibleDataServer.id
  collation = "en_US.utf8"
  charset   = "utf8"

}
/*----------------------------------------------------------------------------------------*/
#  azurerm_postgresql_flexible_server_firewall_rule
/*----------------------------------------------------------------------------------------*/

resource "azurerm_postgresql_flexible_server_firewall_rule" "example" {
  name      = "example-fw"
  server_id = azurerm_postgresql_flexible_server.PosrgreSQLFlexibleDataServer.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"

}

/*----------------------------------------------------------------------------------------*/
#  azurerm_postgresql_flexible_server_configuration
/*----------------------------------------------------------------------------------------*/
resource "azurerm_postgresql_flexible_server_configuration" "flexible_server_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.PosrgreSQLFlexibleDataServer.id
  value     = "off"


}