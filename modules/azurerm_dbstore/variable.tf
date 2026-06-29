variable "dbstore" {
  description = "The configuration of the database and database server"
  type = map(object({
    resource_group_name = string
    sql_server_location = string
    sql_server_name     = string
    sql_server_user     = string
    sql_server_pass     = string
    sql_database_name   = string


  }))
}