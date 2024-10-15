#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}


#PUBLIC IP
public_ip_variable = {
  "public_ip_1" = {
    name                    = "ploceuspublicip000001a"
    resource_group_name     = "ploceusrg000001"
    location                = "westus2"
    ip_version              = "IPv4"
    allocation_method       = "Static"
    sku                     = "Standard"
    sku_tier                = "Regional"
    public_ip_dns           = "ploceuspublicip000001a"
    idle_timeout_in_minutes = "30"
    availability_zone       = "1"
    reverse_fqdn            = null
    ip_tags                 = null
    public_ip_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  } #,
  #    "public_ip_1" = {
  #     name    = "ploceuspublicip000001b"
  #     ip_version       = "IPv4"
  #     allocation       = "Static"
  #     sku              = "Standard"
  #     public_ip_dns    = "ploceuspublicip000001b"
  #     idle_timeout_in_minutes     = "30"
  #     zone             = ["1"]
  #     public_ip_tags = {
  #       Created_By = "Ploceus",
  #       Department = "CIS"
  #     }
  #  }
}