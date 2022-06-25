
/*----------------------------------------------------------------------------------------*/
/* # Configure the Azure providers              
/*----------------------------------------------------------------------------------------*/
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.2.2"
}

