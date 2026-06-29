resource "azurerm_private_endpoint" "mypvtendpoint" {
  depends_on          = [data.azurerm_subnet.pvtendpointSubnet, data.azurerm_container_registry.azure_acr]
  for_each            = var.pvtendpoint_config
  name                = each.value.pvtendpt_name
  location            = each.value.pvtendpt_location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.pvtendpointSubnet[each.key].id
  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = data.azurerm_container_registry.azure_acr[each.key].id
    subresource_names              = ["registry"]
    is_manual_connection           = each.value.private_service_connection.is_manual_connection
  }

  private_dns_zone_group {
    name = "acr-zone-group"
    private_dns_zone_ids = [
      data.azurerm_private_dns_zone.pvtdnszone[each.key].id
    ]
  }
}