terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "btr_azure_resource_group" {
  name     = var.azure_rg_name
  location = var.azure_rg_location
  tags = {
    Name     = var.azure_rg_name
    CreatedBy = var.terraform_metatag
  }
}