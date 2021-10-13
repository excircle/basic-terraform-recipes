# Deploy Single Virtual Machine

The Terraform code in this repository deploys a single virtual machine to Azure.

# Prerequisites

### Azure CLI

This code was tested using the `az` or "Azure CLI" utility.

If you need to install the Azure CLI on MacOS, current Mac distributions should be able to install it via [Homebrew](https://brew.sh/).

The Homebrew command to install Azure CLI is provided below:

```bash
brew update && brew install azure-cli
```

Once you have have Azure CLI installed, you can login to your Azure account using the following command.

```bash
az login
```

### Azure Source Image Reference

Using Terraform with Azure (for Virtual Machine provisioning) requires that you look up and use the "Source Image Reference."

This is a list of Azure specific metadata that specifies with operating system image to use with your deployment.

The best way to obtain the Source Image Reference is using the Azure CLI.

An example has been provided below:

```bash
user@macbook~$ az vm image list --output table

Offer                         Publisher               Sku                 Urn                                                             UrnAlias             Version
----------------------------  ----------------------  ------------------  --------------------------------------------------------------  -------------------  ---------
CentOS                        OpenLogic               7.5                 OpenLogic:CentOS:7.5:latest                                     CentOS               latest
debian-10                     Debian                  10                  Debian:debian-10:10:latest                                      Debian               latest
RHEL                          RedHat                  7-LVM               RedHat:RHEL:7-LVM:latest                                        RHEL                 latest
```

Once you obtain this, you can use this information to fill out the following subsection of the `azurerm_linux_virtual_machine` terraform module

```hcl
# Example
  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
```

# Basic Example Of Deploying Azure VM

