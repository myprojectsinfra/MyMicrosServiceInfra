resource "azurerm_mssql_server" "microdbserver" {

  for_each                     = var.dbstore
  name                         = each.value.sql_server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.sql_server_location
  version                      = "12.0"
  administrator_login          = each.value.sql_server_user
  administrator_login_password = each.value.sql_server_pass
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "microdb" {
  depends_on   = [azurerm_mssql_server.microdbserver]
  for_each     = var.dbstore
  name         = each.value.sql_database_name
  server_id    = azurerm_mssql_server.microdbserver[each.key].id
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

}