variable "appgtw_config" {
  description = "The configuration values for public ip"
  type = map(object({
    appgtw_name          = string
    appgtw_location      = string
    resource_group_name  = string
    appgtw_subnet_name   = string
    virtual_network_name = string
    appgtwpip_name       = string
    appgtw_sku = object({
      sku_name     = string
      sku_tier     = string
      sku_capacity = number
    })

    gateway_ip_configuration = object({
      name = string

    })
    frontend_ip_configuration = object({
      name = string

    })
    waf_configuration = object({
      enabled          = bool
      firewall_mode    = string
      rule_set_version = string

    })
  }))
}