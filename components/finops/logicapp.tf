resource "azurerm_logic_app_workflow" "finopslogicapp" {
  name                = "finopsdata${var.env}logicapp"
  location            = azurerm_resource_group.finopsrg.location
  resource_group_name = azurerm_resource_group.finopsrg.name

  tags = module.ctags.common_tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.finopslogicapp-mi.id]
  }

  lifecycle {
    ignore_changes = [
      parameters
    ]
  }

}

resource "azurerm_user_assigned_identity" "finopslogicapp-mi" {
  resource_group_name = azurerm_resource_group.finopsrg.name
  location            = azurerm_resource_group.finopsrg.location
  name                = "finopslogicapp-${var.env}-mi"
  tags                = module.ctags.common_tags
}

data "local_file" "logic_app" {
  count    = var.env == "ptl" ? 1 : 0
  filename = "${path.module}/logicapp-workflows/workflow-${var.env}.json"
}

resource "azurerm_resource_group_template_deployment" "logic_app_deployment" {
  count               = var.env == "ptl" ? 1 : 0
  resource_group_name = azurerm_resource_group.finopsrg.name
  deployment_mode     = "Incremental"
  name                = "logic-app-deployment"

  template_content = data.local_file.logic_app[0].content

  parameters_content = jsonencode({
    "logic_app_name" = { value = azurerm_logic_app_workflow.finopslogicapp.name }
    "location"       = { value = azurerm_logic_app_workflow.finopslogicapp.location }
  })

  depends_on = [azurerm_logic_app_workflow.finopslogicapp]
}