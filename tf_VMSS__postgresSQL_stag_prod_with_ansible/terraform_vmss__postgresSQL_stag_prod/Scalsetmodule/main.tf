
/*---------------------------------------------*/
/* --- required_providers
/*---------------------------------------------*/
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}
/*---------------------------------------------*/
/* --- azurerm_shared_image_version
/*---------------------------------------------*/
# --- If you creating vm from image, uncomment this
# data "azurerm_shared_image_version" "ServerImage" {
#   name                = "0.0.1" #var.weight_app_image_version_name
#   image_name          = "front_end_image_linux_name"
#   gallery_name        = "azure_gallery_for_images" # var.weight_app_image_gallery_name
#   resource_group_name = "rg_front_end_image"
# }

/*----------------------------------------------------------------------------------------*/
# THIS IS A LINUX MACHINE SCALE SET FOR THE ELASTIC SOLUTION AGAIN THERE ARE SPECIAL FEATURE'S
# THAT ARE DIFFERENT FROM THE MINIMUM STANDARD REQUIREMENTS AND THAT ARE CUSTOMIZED TO OUR NEEDS
/*----------------------------------------------------------------------------------------*/
resource "azurerm_linux_virtual_machine_scale_set" "AppScaleSet" {
  name                = var.ScaleSetName
  resource_group_name = var.group_name
  location            = var.group_location
  sku                 = "Standard_B1ls"
  instances           = var.instance_num

# --- Connection with user and password (without ssh)

  admin_username                  = var.admin_user_name
  admin_password                  = var.admin_password
  disable_password_authentication = false
  /*---------------------------------------------*/


  # health_probe_id                 = azurerm_lb_probe.Helthprobe.id  ##not needed at the moment. uncomment if so

  upgrade_mode = "Automatic"


  # --- if you will need linux 16.04-LTS VM , you can uncomment it and comment source_image_id
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
  # #---will take the image that has been created with all configurations for elastic scale set
  # source_image_id = data.azurerm_shared_image_version.ServerImage.id 

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "AppScaleSet-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.azurerm_subnet_id

      /*  this line connects the scale set to a backend pool */
      /*  of the load balancer we want to handle the load :) */
      load_balancer_backend_address_pool_ids = [var.azurerm_lb_backend_pool_Scale_set_module_id]
    }
  }
  lifecycle {
    ignore_changes = [instances]
  }
    tags ={
    name = var.tags
  }

}
