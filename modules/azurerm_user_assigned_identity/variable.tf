variable "userai_config" {
  description = "The configuration values of the azure user assigned identity"
  type = map(object({
    userai_name         = string
    userai_location     = string
    resource_group_name = string

  }))
}