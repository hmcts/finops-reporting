resource "azurerm_logic_app_workflow" "finopslogicapp" {
  count               = var.env == "ptl" ? 1 : 0
  name                = "finopsdata${var.env}logicapp"
  location            = azurerm_resource_group.finopsrg.location
  resource_group_name = azurerm_resource_group.finopsrg.name

  tags = module.ctags.common_tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.finopslogicapp-mi[0].id]
  }
}

resource "azurerm_user_assigned_identity" "finopslogicapp-mi" {
  count               = var.env == "ptl" ? 1 : 0
  resource_group_name = azurerm_resource_group.finopsrg.name
  location            = azurerm_resource_group.finopsrg.location
  name                = "finopslogicapp-${var.env}-mi"
  tags                = module.ctags.common_tags
}
