data "azurerm_subnet" "pvtendpointSubnet" {
  for_each             = var.pvtendpoint_config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


data "azurerm_container_registry" "azure_acr" {
  for_each            = var.pvtendpoint_config
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_private_dns_zone" "pvtdnszone" {
  for_each            = var.pvtendpoint_config
  name                = each.value.dnszone_acr_name
  resource_group_name = each.value.resource_group_name
}