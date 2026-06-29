resource "azurerm_public_ip" "mypip" {
  for_each            = var.pip_config
  name                = each.value.pip_name
  location            = each.value.pip_location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.pip_allocation_method
  sku                 = each.value.pip_sku
}