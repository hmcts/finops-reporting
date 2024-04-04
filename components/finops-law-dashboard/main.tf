resource "azurerm_resource_group" "finops-law-dashboard-rg" {
  name     = "finops-law-dashboard-${var.env}-rg"
  location = var.location

  tags = module.ctags.common_tags
}



module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}
