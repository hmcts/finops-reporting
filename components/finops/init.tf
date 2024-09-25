locals {
  log_analytics = {
    ptl = {
      subscription = "8999dec3-0104-4a27-94ee-6588559729d1"
    },
    sbox = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
  }
}

terraform {
  required_version = ">= 1.0.10"

  backend "azurerm" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  subscription_id            = local.log_analytics[var.env].subscription
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics"
}