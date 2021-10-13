variable "azure_rg_name" {
  type    = string
  default = "btf-vm-resource-group-1"
}

variable "terraform_metatag" {
  type    = string
  default = "terraform"
}

variable "azure_rg_location" {
  type    = string
  default = "West US 2"
}

variable "az_virt_network_name" {
  type    = string
  default = "btf_az_vm_vnet"
}

variable "az_vm_subnet_name" {
  type    = string
  default = "btr_az_vm_subnet"
}

variable "az_vm_pub_ip" {
  type    = string
  default = "btr_az_vm_public_ip_address"
}

variable "az_vm_net_sec_group_name" {
  type    = string
  default = "btf_az_vm_network_security_group"
}

variable "az_net_sec_allow_ssh" {
  type    = string
  default = "btf_az_vm_net_sec_ssh_allow_rule"
}

variable "az_vm_net_iface" {
  type    = string
  default = "btr_az_vm_network_interface"
}

variable "az_vm_stg_acct" {
  type    = string
  default = "kalajstorageaccount2"
}

variable "az_vm_net_iface_conf_name" {
  type    = string
  default = "btr_az_vm_ip_configuration"
}

variable "az_vm_ssh_key_name" {
  type    = string
  default = "btr_az_vm_ssh_key"
}

variable "az_vm_ssh_key_location" {
  type    = string
  default = "/Users/akalaj/.ssh/box-key.pub"
}

variable "az_virtual_machine_name" {
  type    = string
  default = "btr-vm-node-1"
}

variable "az_virtual_machine_size" {
  type    = string
  default = "Standard_D1_v2"
}

variable "az_virtual_machine_admin" {
  type    = string
  default = "akalaj"
}

