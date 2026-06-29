resource "azurerm_container_registry" "myacr" {
  for_each            = var.acr_config
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.acr_location
  sku                 = each.value.acr_sku
  admin_enabled       = each.value.acr_admin_enabled
  georeplications {
    location                = each.value.acr_geo_location
    zone_redundancy_enabled = true
    tags                    = {}
  }

}