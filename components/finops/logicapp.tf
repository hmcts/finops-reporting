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

resource "azurerm_role_assignment" "finopslogicapp-sa" {
  count                = var.env == "ptl" ? 1 : 0
  scope                = azurerm_storage_account.finopssa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi[0].principal_id
}

resource "azurerm_role_assignment" "finopslogicapp-la" {
  count                = var.env == "ptl" ? 1 : 0
  scope                = data.azurerm_log_analytics_workspace.loganalytics[0].id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi[0].principal_id

  provider = azurerm.log_analytics
}

data "azurerm_log_analytics_workspace" "loganalytics" {
  count               = var.env == "ptl" ? 1 : 0
  name                = var.env == "ptl" ? "hmcts-prod" : "hmcts-nonprod"
  resource_group_name = "oms-automation"
}