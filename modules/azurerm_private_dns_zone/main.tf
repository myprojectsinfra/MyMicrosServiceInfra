resource "azurerm_private_dns_zone" "mypvtdnszone" {
  for_each            = var.pvtdnszone_config
  name                = each.value.dns_name
  resource_group_name = each.value.resource_group_name
}