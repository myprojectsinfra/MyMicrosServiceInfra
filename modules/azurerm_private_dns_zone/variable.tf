variable "pvtdnszone_config" {
  description = "The configuration values for dns zone"
  type = map(object({
    dns_name            = string
    resource_group_name = string
  }))
}