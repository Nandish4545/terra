terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0" # Optional but recommended in production
    }    
  }
  backend "azurerm" {
    resource_group_name = "de"
    storage_account_name = "sa485575635"
    container_name = "check"
    key = "tfstate"
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "31409f85-66af-4625-bef6-af9e5c463410"
  features {}
}

# Create Resource Group 
resource "azurerm_resource_group" "my_demo_rg1" {
  location = "eastus"
  name = "mygclaas-rg"  
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my_demo_rg1.location
  resource_group_name = azurerm_resource_group.my_demo_rg1.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-demo"
  resource_group_name  = azurerm_resource_group.my_demo_rg1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

