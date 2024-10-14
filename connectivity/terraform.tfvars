# Connectivity Subscription 

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-plz-connectivity-rg-01" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}