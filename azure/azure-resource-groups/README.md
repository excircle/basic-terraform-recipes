# Terraform Recipe For Azure Resource Groups

Basic deploy for creating an Azure resource group

```hcl
resource "azurerm_resource_group" "example_resource_group" {
    location = "westus2"
    name     = "basic-resource-1"
    tags     = {
        CreatedBy = "terraform"
        Name      = "basic-resource-1"
    }
}
```