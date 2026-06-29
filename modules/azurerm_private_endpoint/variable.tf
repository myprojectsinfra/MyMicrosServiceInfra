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