# provider "azurerm" {
#   subscription_id = "524f5e9d-06fd-4e7f-a42e-6b34e559a553"
#   # 524f5e9d-06fd-4e7f-a42e-6b34e559a553	Dev-12
#   # e3d2d88d-b54a-4fb7-b918-3cb24aad9ba9	Dev-17
#   client_id     = "53b4a79e-e1eb-4415-aa11-7a3fee9e09fc"
#   client_secret = "LxW..Ur3yvn0YFc4Gb~H69l1yeJkYADoKL"
#   tenant_id     = "687f51c3-0c5d-4905-84f8-97c683a5b9d1"
#   features {}
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.98.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}