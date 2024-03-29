resource "azurerm_resource_group" "finopsrg" {
  name     = "finopsdata${var.env}rg"
  location = var.location

  tags = module.ctags.common_tags
}

resource "azurerm_storage_account" "finopssa" {
  name                     = "finopsdata${var.env}sa"
  resource_group_name      = azurerm_resource_group.finopsrg.name
  location                 = azurerm_resource_group.finopsrg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = module.ctags.common_tags
}

resource "azurerm_storage_container" "finopssacontainer" {
  name                  = "finopsdata"
  storage_account_name  = azurerm_storage_account.finopssa.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "finopsblobs" {
  for_each = fileset(path.module, "../../file_uploads/*")

  name                   = trim(each.key, "../../file_uploads/")
  storage_account_name   = azurerm_storage_account.finopssa.name
  storage_container_name = azurerm_storage_container.finopssacontainer.name
  type                   = "Block"
  source                 = each.key
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}
