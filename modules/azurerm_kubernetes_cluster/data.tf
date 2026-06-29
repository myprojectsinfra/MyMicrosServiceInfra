data "azurerm_subnet" "aksSubnet" {
  for_each             = var.aks_config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_user_assigned_identity" "uaid" {
  for_each            = var.aks_config
  name                = each.value.useraid_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_log_analytics_workspace" "loganwork" {
  for_each            = var.aks_config
  name                = each.value.loganwork_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_container_registry" "azure_acr" {
  for_each            = var.aks_config
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_application_gateway" "appgtw" {
  for_each            = var.aks_config
  name                = each.value.appgtw_name
  resource_group_name = each.value.resource_group_name
}