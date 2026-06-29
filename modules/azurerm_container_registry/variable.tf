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