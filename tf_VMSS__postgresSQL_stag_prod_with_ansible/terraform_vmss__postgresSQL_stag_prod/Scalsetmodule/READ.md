<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.65 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.AppScaleSet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.AutoScaling](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ScaleSetName"></a> [ScaleSetName](#input\_ScaleSetName) | ScaleSetName | `string` | `"AppScaleSet"` | no |
| <a name="input_VnetName"></a> [VnetName](#input\_VnetName) | VnetName | `string` | `"Vnet"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | password for vm login | `string` | n/a | yes |
| <a name="input_admin_user_name"></a> [admin\_user\_name](#input\_admin\_user\_name) | user name vor vm login | `string` | n/a | yes |
| <a name="input_azurerm_lb_backend_pool_Scale_set_module_id"></a> [azurerm\_lb\_backend\_pool\_Scale\_set\_module\_id](#input\_azurerm\_lb\_backend\_pool\_Scale\_set\_module\_id) | azurerm\_lb\_backend\_pool\_Scale\_set\_module\_id | `string` | n/a | yes |
| <a name="input_azurerm_subnet_id"></a> [azurerm\_subnet\_id](#input\_azurerm\_subnet\_id) | azurerm\_subnet\_id | `string` | n/a | yes |
| <a name="input_group_location"></a> [group\_location](#input\_group\_location) | group\_location | `string` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | group\_name | `string` | n/a | yes |
| <a name="input_host_url"></a> [host\_url](#input\_host\_url) | host\_url | `string` | `""` | no |
| <a name="input_instance_num"></a> [instance\_num](#input\_instance\_num) | instance\_num | `number` | `2` | no |
| <a name="input_pg_host"></a> [pg\_host](#input\_pg\_host) | pg\_host | `string` | `""` | no |
| <a name="input_pg_pass"></a> [pg\_pass](#input\_pg\_pass) | pg\_pass | `string` | `""` | no |
| <a name="input_pg_user"></a> [pg\_user](#input\_pg\_user) | pg\_user | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags | `string` | `"enviroment"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | n/a |
<!-- END_TF_DOCS -->