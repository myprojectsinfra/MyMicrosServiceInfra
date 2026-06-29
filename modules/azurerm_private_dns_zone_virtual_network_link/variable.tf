variable "pvtdnszonevnetlink_config" {
  description = "The configuration values for private dns zone virtual network link config"
  type = map(object({
    link_name            = string
    dns_name             = string
    resource_group_name  = string
    virtual_network_name = string
  }))
}