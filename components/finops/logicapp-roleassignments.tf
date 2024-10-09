resource "azurerm_role_assignment" "finopslogicapp-sa" {
  scope                = azurerm_storage_account.finopssa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi.principal_id
}

resource "azurerm_role_assignment" "finopslogicapp-la" {
  count                = var.env == "ptl" ? 1 : 0
  scope                = data.azurerm_log_analytics_workspace.loganalytics-hmctsprod[0].id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi.principal_id

  provider = azurerm.log_analytics_hmctsprod
}

data "azurerm_log_analytics_workspace" "loganalytics-hmctsprod" {
  count               = var.env == "ptl" ? 1 : 0
  name                = "hmcts-prod"
  resource_group_name = "oms-automation"

  provider = azurerm.log_analytics_hmctsprod
}

resource "azurerm_role_assignment" "finopslogicapp-la-hmctsnonprod" {
  count                = var.env == "ptl" ? 1 : 0
  scope                = data.azurerm_log_analytics_workspace.loganalytics-hmctsnonprod[0].id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi.principal_id

  provider = azurerm.log_analytics_hmctsnonprod
}

data "azurerm_log_analytics_workspace" "loganalytics-hmctsnonprod" {
  count               = var.env == "ptl" ? 1 : 0
  name                = "hmcts-nonprod"
  resource_group_name = "oms-automation"

  provider = azurerm.log_analytics_hmctsnonprod
}

resource "azurerm_role_assignment" "finopslogicapp-la-hmctsqa" {
  count                = var.env == "ptl" ? 1 : 0
  scope                = data.azurerm_log_analytics_workspace.loganalytics-hmctsqa[0].id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi.principal_id

  provider = azurerm.log_analytics_hmctsqa
}

data "azurerm_log_analytics_workspace" "loganalytics-hmctsqa" {
  count               = var.env == "ptl" ? 1 : 0
  name                = "hmcts-qa"
  resource_group_name = "oms-automation"

  provider = azurerm.log_analytics_hmctsqa
}

resource "azurerm_role_assignment" "finopslogicapp-la-hmctssbox" {
  count                = var.env == "sbox" ? 1 : 0
  scope                = data.azurerm_log_analytics_workspace.loganalytics-hmctssbox[0].id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azurerm_user_assigned_identity.finopslogicapp-mi.principal_id

  provider = azurerm.log_analytics_hmctssbox
}

data "azurerm_log_analytics_workspace" "loganalytics-hmctssbox" {
  count               = var.env == "sbox" ? 1 : 0
  name                = "hmcts-sandbox"
  resource_group_name = "oms-automation"

  provider = azurerm.log_analytics_hmctssbox
}