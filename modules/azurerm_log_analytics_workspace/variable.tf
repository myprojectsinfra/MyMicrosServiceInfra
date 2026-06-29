variable "loganalytics_config" {
  description = "The configuration values of the azure log analytics workspace"
  type = map(object({
    loganalytics_name     = string
    loganalytics_location = string
    resource_group_name   = string
    loganalytics_sku      = string

  }))
}