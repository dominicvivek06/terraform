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