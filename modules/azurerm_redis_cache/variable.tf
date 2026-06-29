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