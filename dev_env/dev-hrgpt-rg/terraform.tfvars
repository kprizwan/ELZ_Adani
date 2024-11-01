# Stage Subscription Medium

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-common-dev-hrgpt-rg" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}