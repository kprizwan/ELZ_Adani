#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
}

#NAT GATEWAY
nat_gateway_variables = {
  "nat_gateway_1" = {
    nat_gateway_idle_timeout_in_minutes = "4"               #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
    nat_gateway_name                    = "ploceusrg000001" #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_location                = "westus2"         #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name     = "ploceusrg000001" #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_sku_name                = "Standard"        #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard.
    nat_gateway_zones                   = ["1"]             #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
    nat_gateway_tags = {                                    #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}