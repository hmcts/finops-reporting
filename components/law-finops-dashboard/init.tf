terraform {
  required_version = ">= 1.7.5"

  backend "azurerm" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.117.1"
    }
  }
}

provider "azurerm" {
  features {}
}