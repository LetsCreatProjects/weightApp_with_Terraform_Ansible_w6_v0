

## Installation:
    1- Install Terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
    2- Create azure account
    3- Install the Azure CLI and authenticate with Azure with the following command:
    az login


## Configuration
- Create an image with web app configuration based on this repository: https://github.com/LetsCreatProjects/bootcamp-app.git
- The configuration of the app you can find here: https://www.youtube.com/watch?v=LWPIdzeiThs
- For keeping app up at restart you can use pm2.



 terraform_creating_elastic_scaleset_with_postgres is template that building an Elastic High Availability virtual network on azure with terraform code. On that infrastructure we are going to deploy a Node.js Weight Tracker App.
input for variables for via .tfvars:

- VnetName               = ""
- admin_user_name        = ""
- admin_password         = "!"
- pg_user                = ""
- pg_pass                = ""
- address_space          = [""]
- addr_prefixes_Web_Tier = [""]
- addr_prefixes_Data_Tier= [""]
- RG    = ""
- dns_postgresSQL        = ""
- dns_loadBalancer       = ""
- ip_connecter_via_RDP   = ""
- location               = ""



please notice if .tfvars file is needed to add to command: -var-file="{filename}.tfvars"


