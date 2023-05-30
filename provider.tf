# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "0.12.20"

#     }
#    }
#  }


# Defines terraform provider and version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"

    }
  }
 }
# Configure the Microsoft Azure Provider

# provider "azurerm" {
#   version = "0.12.20"
#   features {}

# }



# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 2.12"
#     }
#   }
# }
provider "azurerm" {
  features {}
}