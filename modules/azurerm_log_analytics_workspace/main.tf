resource "azurerm_log_analytics_workspace" "myloganalytics" {
  for_each            = var.loganalytics_config
  name                = each.value.loganalytics_name
  location            = each.value.loganalytics_location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.loganalytics_sku
}