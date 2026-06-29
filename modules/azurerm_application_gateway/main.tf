resource "azurerm_application_gateway" "myappgtw" {
  depends_on          = [data.azurerm_subnet.appgtw_subnet, data.azurerm_public_ip.appgtw_pip]
  for_each            = var.appgtw_config
  name                = each.value.appgtw_name
  location            = each.value.appgtw_location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = each.value.appgtw_sku.sku_name
    tier     = each.value.appgtw_sku.sku_tier
    capacity = each.value.appgtw_sku.sku_capacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration.name
    subnet_id = data.azurerm_subnet.appgtw_subnet[each.key].id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration.name
    public_ip_address_id = data.azurerm_public_ip.appgtw_pip[each.key].id
  }
  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = each.value.frontend_ip_configuration.name
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }
  # waf_configuration {
  #   enabled          = each.value.waf_configuration.enabled
  #   firewall_mode    = each.value.waf_configuration.firewall_mode
  #   rule_set_version = each.value.waf_configuration.rule_set_version
  # }



  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 100
  }
}