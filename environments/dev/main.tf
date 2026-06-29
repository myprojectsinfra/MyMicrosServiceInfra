locals {
  common_tags = {
    environment = "dev"
    owner       = "DevOps Team"
  }
}

module "rg_module" {
  source    = "../../modules/azurerm_resource_group"
  rg_config = var.rg_config
  tags      = local.common_tags
}

module "network_module" {
  depends_on = [module.rg_module]
  source     = "../../modules/azurerm_virtual_network"
  networks   = var.networks
  tags       = local.common_tags
}

module "useridentity_module" {
  depends_on    = [module.rg_module, module.network_module]
  source        = "../../modules/azurerm_user_assigned_identity"
  userai_config = var.userai_config

}

module "acr_module" {
  depends_on = [module.rg_module, module.network_module, module.useridentity_module]
  source     = "../../modules/azurerm_container_registry"
  acr_config = var.acr_config

}

module "loganalytics_module" {
  depends_on          = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module]
  source              = "../../modules/azurerm_log_analytics_workspace"
  loganalytics_config = var.loganalytics_config

}
module "pip_module" {
  depends_on = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module]
  source     = "../../modules/azurerm_public_ip"
  pip_config = var.pip_config
}

module "appgtw_module" {
  depends_on    = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.pip_module]
  source        = "../../modules/azurerm_application_gateway"
  appgtw_config = var.appgtw_config
}
module "aks_module" {
  depends_on = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.pip_module, module.appgtw_module]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_config = var.aks_config

}

# module "redis_module" {
#   depends_on = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module , module.aks_module]
#   source     = "../../modules/azurerm_redis_cache"
#   redis_config = var.redis_config

# }

module "dbstore" {
  depends_on = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.aks_module]
  source     = "../../modules/azurerm_dbstore"
  dbstore    = var.dbstore
}

module "dnszone_module" {
  depends_on        = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.aks_module]
  source            = "../../modules/azurerm_private_dns_zone"
  pvtdnszone_config = var.pvtdnszone_config
}

module "dnszonevnetlink_module" {
  depends_on                = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.aks_module, module.dnszone_module]
  source                    = "../../modules/azurerm_private_dns_zone_virtual_network_link"
  pvtdnszonevnetlink_config = var.pvtdnszonevnetlink_config
}

module "pvtendpoint_module" {
  depends_on         = [module.rg_module, module.network_module, module.useridentity_module, module.acr_module, module.loganalytics_module, module.aks_module, module.dnszone_module]
  source             = "../../modules/azurerm_private_endpoint"
  pvtendpoint_config = var.pvtendpoint_config
}