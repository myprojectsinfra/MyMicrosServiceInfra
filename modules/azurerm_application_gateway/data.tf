data "azurerm_subnet" "appgtw_subnet" {
  for_each             = var.appgtw_config
  name                 = each.value.appgtw_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "appgtw_pip" {
  for_each            = var.appgtw_config
  name                = each.value.appgtwpip_name
  resource_group_name = each.value.resource_group_name
}