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
  subscription_id            = "8999dec3-0104-4a27-94ee-6588559729d1"
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics_hmctsprod"
}

provider "azurerm" {
  subscription_id            = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics_hmctsnonprod"
}

provider "azurerm" {
  subscription_id            = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics_hmctsqa"
}

provider "azurerm" {
  subscription_id            = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics_hmctssbox"
}