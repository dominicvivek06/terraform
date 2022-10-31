terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.28.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "a14c-3a36c623e5ed"
    client_id = "e81c72dc90d4"
    client_secret = "fVyQ7SZjI9iBpctb"
    tenant_id = "e45b9887cbdd"
    features {    }
    
}


locals {
  resource_group = "app_grp"
  location = "UK South"
}



resource "azurerm_resource_group" "app_grp" {
    name = local.resource_group
    location = local.location
  
}


resource "azurerm_virtual_network" "app_network" {
  name                = "app-network"
  location            = local.location
  resource_group_name = local.resource_group
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "SubnetA"
    address_prefix = "10.0.1.0/24"
  }

}



data "azurerm_subnet" "SubnetA" {
  name = "SubnetA"
  virtual_network_name = azurerm_virtual_network.app_network.name
  resource_group_name = local.resource_group
}





resource "azurerm_network_interface" "app_interface" {
  name                = "app-interface"
  location            = local.location
  resource_group_name = local.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.app_public_ip.id
  }
  depends_on = [
    azurerm_virtual_network.app_network,
    azurerm_public_ip.app_public_ip
  ]
}