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

resource "azurerm_resource_group" "btr_vm_azure_resource_group" {
  name     = var.azure_rg_name
  location = var.azure_rg_location
  tags = {
    Name      = var.azure_rg_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_virtual_network" "az_virtual_network" {
  name                = var.az_virt_network_name
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Name      = var.az_virt_network_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_subnet" "az_vm_subnet" {
  name                 = var.az_vm_subnet_name
  resource_group_name  = azurerm_resource_group.btr_vm_azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.az_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "az_vm_public_ip" {
  name                = var.az_vm_pub_ip
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location

  tags = {
    Name      = var.az_vm_subnet_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_network_security_group" "az_vm_net_sec_group" {
  name                = var.az_vm_net_sec_group_name
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name

  security_rule {
    name                       = var.az_net_sec_allow_ssh
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name      = var.az_vm_subnet_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_network_interface" "az_vm_network_iface" {
  name                = var.az_vm_net_iface
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name

  ip_configuration {
    name                          = var.az_vm_net_iface_conf_name
    subnet_id                     = azurerm_subnet.az_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az_vm_public_ip.id
  }

  tags = {
    Name      = var.az_vm_subnet_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_network_interface_security_group_association" "az_net_sec_group_assoc" {
  network_interface_id      = azurerm_network_interface.az_vm_network_iface.id
  network_security_group_id = azurerm_network_security_group.az_vm_net_sec_group.id
}

resource "azurerm_storage_account" "az_vm_storage_account" {
  name                     = var.az_vm_stg_acct
  resource_group_name      = azurerm_resource_group.btr_vm_azure_resource_group.name
  location                 = azurerm_resource_group.btr_vm_azure_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Name      = var.az_vm_subnet_name
    CreatedBy = var.terraform_metatag
  }
}

resource "azurerm_ssh_public_key" "az_vm_ssh_key" {
  name                = var.az_vm_ssh_key_name
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location
  public_key          = file(var.az_vm_ssh_key_location)
}


resource "azurerm_linux_virtual_machine" "btr_azure_virtual_machine" {
  name                = var.az_virtual_machine_name
  resource_group_name = azurerm_resource_group.btr_vm_azure_resource_group.name
  location            = azurerm_resource_group.btr_vm_azure_resource_group.location
  size                = var.az_virtual_machine_size
  admin_username      = var.az_virtual_machine_admin
  network_interface_ids = [
    azurerm_network_interface.az_vm_network_iface.id,
  ]

  admin_ssh_key {
    username   = var.az_virtual_machine_admin
    public_key = file(var.az_vm_ssh_key_location)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}