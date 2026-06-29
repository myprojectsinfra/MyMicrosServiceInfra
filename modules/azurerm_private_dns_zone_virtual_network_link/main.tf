resource "azurerm_private_dns_zone_virtual_network_link" "mydnsvnetlink" {
  depends_on            = [data.azurerm_virtual_network.myvnet]
  for_each              = var.pvtdnszonevnetlink_config
  name                  = each.value.link_name
  resource_group_name   = each.value.resource_group_name
  private_dns_zone_name = each.value.dns_name

  virtual_network_id = data.azurerm_virtual_network.myvnet[each.key].id
}