resource "azurerm_resource_group" "law-finops-dashboard-rg" {
  name     = "law-finops-dashboard-${var.env}-rg"
  location = var.location
  tags     = module.ctags.common_tags
}

data "template_file" "dash-template" {
  template = "${file("${path.module}/dash.tpl")}"
}

resource "azurerm_portal_dashboard" "law-finops-dashboard" {
  name                 = "${var.law_name}-law-finops-dashboard"
  resource_group_name  = azurerm_resource_group.law-finops-dashboard-rg.name
  location             = azurerm_resource_group.law-finops-dashboard-rg.location
  tags                 = module.ctags.common_tags
  dashboard_properties = data.template_file.dash-template.rendered
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}