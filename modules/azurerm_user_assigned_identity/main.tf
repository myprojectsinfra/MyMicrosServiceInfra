resource "azurerm_user_assigned_identity" "myuseridentity" {
  for_each            = var.userai_config
  name                = each.value.userai_name
  location            = each.value.userai_location
  resource_group_name = each.value.resource_group_name
}