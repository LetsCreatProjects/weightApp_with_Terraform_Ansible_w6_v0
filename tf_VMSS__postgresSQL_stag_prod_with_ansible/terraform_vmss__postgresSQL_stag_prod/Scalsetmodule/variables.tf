
/*----------------------------------------------------------------------------------------*/
#  variables
/*----------------------------------------------------------------------------------------*/

variable "VnetName" {
    default     = "Vnet"
    description = "VnetName"
    
}
variable "ScaleSetName" {
    default = "AppScaleSet"
    description = "ScaleSetName"
}

variable "tags" {

  default = "enviroment"
  description =  "tags" 
}

variable group_name {
  type  = string
  description = "group_name"
}

variable group_location {
    type  = string
    description = "group_location"
}

variable admin_user_name  {
    type  = string
    description = "user name vor vm login"

}

variable admin_password {
      type        = string
      description = "password for vm login"
}

variable azurerm_subnet_id  {

      type        = string
      description = "azurerm_subnet_id"
}

variable azurerm_lb_backend_pool_Scale_set_module_id {
      type        = string
      description = "azurerm_lb_backend_pool_Scale_set_module_id"
}






variable "pg_user" {
    default = ""
    description = "pg_user"
}

variable "pg_pass" {
    default = ""
    description = "pg_pass"
}

variable "host_url" {
    default = ""
    description = "host_url"
}

variable "pg_host" {
    default = ""
    description = "pg_host"
}
variable "instance_num" {
    default = 2
    description = "instance_num"
}


# variable "okta_secret" {
#     default = ""
#     description = "okta_secret"
# }

# variable "okta_client_id" {
#     default = ""
#     description = "okta_client_id"
# }

# variable "okta_org_url" {
#     default = ""
#     description = "okta_org_url"
# }

# variable "okta_key" {
#     default = ""
#     description = "okta_key"
# }

