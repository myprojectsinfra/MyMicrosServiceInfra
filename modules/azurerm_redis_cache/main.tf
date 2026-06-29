resource "azurerm_redis_cache" "myredis" {
  for_each            = var.redis_config
  name                = each.value.redis_name
  location            = each.value.redis_location
  resource_group_name = each.value.resource_group_name
  capacity            = each.value.redis_capacity
  family              = each.value.redis_family
  sku_name            = each.value.redis_sku_name
}