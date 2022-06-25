# for more readable template we divide as much as possible 
# this section is for the network security groups we need 

/*----------------------------------------------------------------------------------------*/
# A NETWORK SECURITY GROUP PLUS AN ASSOCIATION TO THE WEB TIER SUBNET 
# this network security group will have the azure standard plus an opening of port 8080 
#  to start listening for app request 
/*----------------------------------------------------------------------------------------*/
resource "azurerm_subnet_network_security_group_association" "NSG_frontend" {
  subnet_id                 = azurerm_subnet.Web_Tier.id
  network_security_group_id = azurerm_network_security_group.NSG_frontend.id

}

resource "azurerm_network_security_group" "NSG_frontend" {
  name                = "NSG_frontend"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  security_rule {
    name                       = "ssh"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = var.ip_connecter_via_ssh # "*" #put here access from your ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh_from_LB"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = azurerm_public_ip.LoadBalacerPublicIp.ip_address # "*" # access from load balncer to instances
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_8080"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "Deny"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

/*----------------------------------------------------------------------------------------*/
/* A NETWORK SECURITY GROUP PLUS AN ASSOCIATION TO THE DATA TIER SUBNET                   */
/*----------------------------------------------------------------------------------------*/
resource "azurerm_subnet_network_security_group_association" "NSG_backend_association" {
  subnet_id                 = azurerm_subnet.Data_Tier.id
  network_security_group_id = azurerm_network_security_group.NSG_backend.id

}
/*----------------------------------------------------------------------------------------*/
/* BECAUSE WE WANT THE DATA TIER TO REMAINED "HIDDEN" TO OUTSIDE EYES WE CAN LEAVE THE STANDARD  */
/* AZURE NSG BLOCK THAT ALLOWS ONLY INSIDE NETWORK COMMUNICATIONS                                */
/*----------------------------------------------------------------------------------------*/

resource "azurerm_network_security_group" "NSG_backend" {
  name                = "NSG_backend"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  security_rule {
    name                       = "Postgres"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5432"
    destination_port_range     = "5432"
    source_address_prefix      = var.addr_prefixes_Web_Tier[0] #["${azurerm_public_ip.LoadBalacerPublicIp.ip_address}","${var.addr_prefixes_Web_Tier[0]}"] #"10.10.1.0/24" #"virtualnetwork"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "controller access"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_public_ip.LoadBalacerPublicIp.ip_address  # "*" #put here access from LB ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
/*----------------------------------------------------------------------------------------*/
