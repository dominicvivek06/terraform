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
