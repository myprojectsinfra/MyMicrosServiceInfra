variable "subscription_id" {
  description = "The value of the subscription id"
  type        = string
}

variable "rg_config" {
  description = "The configuration values of the resource group"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    managed_by              = optional(string)
  }))
}

variable "networks" {
  description = "The Configuration of Virtual Networks"
  type = map(object(
    {
      virtual_network_name     = string
      resource_group_name      = string
      virtual_network_location = string
      address_space            = list(string)
      subnets = optional(map(object(
        {
          subnet_name      = string
          address_prefixes = list(string)
        }
      )), {})

    }
  ))

}

variable "userai_config" {
  description = "The configuration values of the azure user assigned identity"
  type = map(object({
    userai_name         = string
    userai_location     = string
    resource_group_name = string

  }))
}

variable "acr_config" {
  description = "The configuration values of the azure container registry"
  type = map(object({
    acr_name            = string
    acr_location        = string
    resource_group_name = string
    acr_sku             = string
    acr_admin_enabled   = bool
    acr_geo_location    = string
  }))
}

variable "loganalytics_config" {
  description = "The configuration values of the azure log analytics workspace"
  type = map(object({
    loganalytics_name     = string
    loganalytics_location = string
    resource_group_name   = string
    loganalytics_sku      = string

  }))
}

variable "aks_config" {
  description = "The configuration values of the azure kubernetes cluster"
  type = map(object({
    aks_cluster_name     = string
    aks_cluster_location = string
    resource_group_name  = string
    default_node_pool = object({
      name                 = string
      vm_size              = string
      auto_scaling_enabled = bool
      min_count            = number
      max_count            = number
    })

    identity = object({
      type = string

    })
    virtual_network_name = string
    useraid_name         = string
    loganwork_name       = string
    acr_name             = string
    subnet_name          = string
    appgtw_name          = string
  }))
}

variable "redis_config" {
  description = "The configuration values of redis cache"
  type = map(object({
    redis_name          = string
    redis_location      = string
    resource_group_name = string
    redis_family        = string
    redis_capacity      = number
    redis_sku_name      = string
  }))
}

variable "pip_config" {
  description = "The configuration values for public ip"
  type = map(object({
    pip_name              = string
    pip_location          = string
    resource_group_name   = string
    pip_allocation_method = string
    pip_sku               = string
  }))
}

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

variable "pvtdnszone_config" {
  description = "The configuration values for dns zone"
  type = map(object({
    dns_name            = string
    resource_group_name = string
  }))
}

variable "pvtdnszonevnetlink_config" {
  description = "The configuration values for private dns zone virtual network link config"
  type = map(object({
    link_name            = string
    dns_name             = string
    resource_group_name  = string
    virtual_network_name = string
  }))
}

variable "dbstore" {
  description = "The configuration of the database and database server"
  type = map(object({
    resource_group_name = string
    sql_server_location = string
    sql_server_name     = string
    sql_server_user     = string
    sql_server_pass     = string
    sql_database_name   = string


  }))
}

variable "pvtendpoint_config" {
  description = "The configuration values for private dns zone virtual network link config"
  type = map(object({
    pvtendpt_name        = string
    pvtendpt_location    = string
    resource_group_name  = string
    subnet_name          = string
    virtual_network_name = string
    acr_name             = string
    private_service_connection = object({

      name = string

      is_manual_connection = bool
    })
    dnszone_acr_name = string
    private_dns_zone_group = object({
      name = string
    })

  }))
}