variable "aks_config" {
  description = "The configuration values of the azure kubernetes cluster"
  type = map(object({
    aks_cluster_name     = string
    aks_cluster_location = string
    resource_group_name  = string
    default_node_pool = object({
      name                 = string
      vm_size              = string
      auto_scaling_enabled = bool
      min_count            = number
      max_count            = number
    })

    identity = object({
      type = string

    })
    virtual_network_name = string
    useraid_name         = string
    loganwork_name       = string
    acr_name             = string
    subnet_name          = string
    appgtw_name          = string
  }))
}