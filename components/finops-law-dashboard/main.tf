resource "azurerm_resource_group" "finops-law-dashboard-rg" {
  name     = "finops-law-dashboard-${var.env}-rg"
  location = var.location
  tags     = module.ctags.common_tags
}

resource "azurerm_portal_dashboard" "my-board" {
  name                 = "LAW-FinOps-Dashboard-${var.law_name}"
  resource_group_name  = azurerm_resource_group.finops-law-dashboard-rg.name
  location             = azurerm_resource_group.finops-law-dashboard-rg.location
  tags                 = module.ctags.common_tags
  dashboard_properties = <<DASH
{
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 7,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourcegroups/oms-automation/providers/microsoft.operationalinsights/workspaces/${var.law_name}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1014c867-1f44-4739-b110-3c1903151026",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "find where TimeGenerated between(startofday(ago(30d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceGroup\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend EstimatedDataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * 2.27, 2))\n| project-away BillableDataBytes\n| sort by DataIngestedInGB desc \n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${var.law_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "EstimatedDataIngestionCosts": "217px",
                    "ResourceGroup": "161px",
                    "DataIngestionCosts": "182px"
                  },
                  "Query": "find where TimeGenerated between(startofday(ago(30d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceGroup\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend DataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * ${var.costpergb}, 2))\n| project-away BillableDataBytes\n| sort by DataIngestedInGB desc \n\n",
                  "PartTitle": "Logging Ingestion Costs by Resource Group"
                }
              }
            }
          },
          "1": {
            "position": {
              "x": 0,
              "y": 4,
              "colSpan": 15,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourcegroups/oms-automation/providers/microsoft.operationalinsights/workspaces/${var.law_name}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "6d1b5452-5baa-4adf-9c21-41783e137d3c",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "find where TimeGenerated between(startofday(ago(1d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceName, ResourceProvider, ResourceType, ResourceGroup\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend DataIngested = strcat(round(DataIngestedInGB, 2), \" GB\")\n| extend EstimatedDataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * 2.27, 2))\n| project-away BillableDataBytes, DataIngestedInGB\n| sort by DataIngested nulls last\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${var.law_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "EstimatedDataIngestionCosts": "231px",
                    "ResourceGroup": "204px",
                    "ResourceType": "191px",
                    "ResourceProvider": "191px",
                    "ResourceName": "281px",
                    "DataIngestionCosts": "170px"
                  },
                  "Query": "find where TimeGenerated between(startofday(ago(30d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceName, ResourceProvider, ResourceType, ResourceGroup\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend DataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * ${var.costpergb}, 2))\n| project-away BillableDataBytes\n| sort by DataIngestedInGB desc \n\n",
                  "PartTitle": "Logging Ingestion Costs by Resource"
                }
              }
            }
          },
          "2": {
            "position": {
              "x": 0,
              "y": 8,
              "colSpan": 15,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourcegroups/oms-automation/providers/microsoft.operationalinsights/workspaces/${var.law_name}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "62b418ed-b79a-4e45-b149-00e15c0e95fe",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "find where TimeGenerated between(startofday(ago(30d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType, Type\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId, Type\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceName, ResourceProvider, ResourceType, ResourceGroup, Type\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend EstimatedDataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * 2.27, 2))\n| project-away BillableDataBytes\n| sort by DataIngestedInGB desc\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${var.law_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "ResourceName": "287px",
                    "ResourceProvider": "147px",
                    "EstimatedDataIngestionCosts": "222px",
                    "ResourceGroup": "156px",
                    "Type": "131px",
                    "ResourceType": "166px",
                    "DataIngestionCosts": "173px"
                  },
                  "Query": "find where TimeGenerated between(startofday(ago(30d)) .. startofday(now())) project _ResourceId, _BilledSize, _IsBillable, ResourceType, Type\n| where _IsBillable == true \n| summarize BillableDataBytes = sum(_BilledSize) by _ResourceId, Type\n| extend ResourceName = tostring(split(_ResourceId, \"/\")[8])\n| extend ResourceProvider = tostring(split(_ResourceId, \"/\")[6])\n| extend ResourceType = tostring(split(_ResourceId, \"/\")[7])\n| extend ResourceGroup = tostring(split(_ResourceId, \"/\")[4])\n| summarize BillableDataBytes = sum(BillableDataBytes) by ResourceName, ResourceProvider, ResourceType, ResourceGroup, Type\n| extend DataIngestedInGB = round(BillableDataBytes / 1024 / 1024 / 1024, 2)\n| extend DataIngestionCosts = strcat(\"£\", round(DataIngestedInGB * ${var.costpergb}, 2))\n| project-away BillableDataBytes\n| sort by DataIngestedInGB desc\n\n",
                  "PartTitle": "Logging Ingestion Costs by Resource and Log Type"
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "30d"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 30 days"
              },
              "filteredPartIds": [
                "StartboardPart-LogsDashboardPart-32f3a23a-3a4a-4253-8de3-bd1772588103",
                "StartboardPart-LogsDashboardPart-32f3a23a-3a4a-4253-8de3-bd1772588105",
                "StartboardPart-LogsDashboardPart-32f3a23a-3a4a-4253-8de3-bd1772588109"
              ]
            }
          }
        }
      }
    }
  }
DASH
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}
