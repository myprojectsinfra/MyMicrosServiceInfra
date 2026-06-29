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