data "azurerm_virtual_network" "myvnet" {
  for_each            = var.pvtdnszonevnetlink_config
  name                = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}