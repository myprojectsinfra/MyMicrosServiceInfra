resource "azurerm_kubernetes_cluster" "myAKSCluster" {
  depends_on                = [data.azurerm_subnet.aksSubnet, data.azurerm_user_assigned_identity.uaid]
  for_each                  = var.aks_config
  name                      = each.value.aks_cluster_name
  location                  = each.value.aks_cluster_location
  resource_group_name       = each.value.resource_group_name
  dns_prefix                = "aks"
  private_cluster_enabled   = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  sku_tier                  = "Standard"

  default_node_pool {
    name                 = each.value.default_node_pool.name
    vm_size              = each.value.default_node_pool.vm_size
    auto_scaling_enabled = each.value.default_node_pool.auto_scaling_enabled
    min_count            = each.value.default_node_pool.min_count
    max_count            = each.value.default_node_pool.max_count
    vnet_subnet_id       = data.azurerm_subnet.aksSubnet[each.key].id
  }

  identity {
    type = each.value.identity.type
    identity_ids = [
      data.azurerm_user_assigned_identity.uaid[each.key].id
    ]
  }

  oms_agent {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganwork[each.key].id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.appgtw[each.key].id
  }
}


resource "azurerm_role_assignment" "acr_pull" {
  depends_on           = [data.azurerm_container_registry.azure_acr, azurerm_kubernetes_cluster.myAKSCluster]
  for_each             = var.aks_config
  scope                = data.azurerm_container_registry.azure_acr[each.key].id
  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.myAKSCluster[each.key].kubelet_identity[0].object_id
}