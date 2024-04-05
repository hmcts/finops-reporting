resource "azurerm_resource_group" "finops-law-dashboard-rg" {
  name     = "finops-law-dashboard-${var.env}-rg"
  location = var.location

  tags = module.ctags.common_tags
}

resource "azurerm_portal_dashboard" "my-board" {
  name                = "my-cool-dashboard"
  resource_group_name = azurerm_resource_group.finops-law-dashboard-rg.name
  location            = azurerm_resource_group.finops-law-dashboard-rg.location
  tags = module.ctags.common_tags
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
                        "rowSpan": 2,
                        "colSpan": 3
                    },
                    "metadata": {
                        "inputs": [],
                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                        "settings": {
                            "content": {
                                "settings": {
                                    "content": "${testmdcontent}",
                                    "subtitle": "",
                                    "title": ""
                                }
                            }
                        }
                    }
                },               
                "1": {
                    "position": {
                        "x": 5,
                        "y": 0,
                        "rowSpan": 4,
                        "colSpan": 6
                    },
                    "metadata": {
                        "inputs": [],
                        "type": "Extension/HubsExtension/PartType/VideoPart",
                        "settings": {
                            "content": {
                                "settings": {
                                    "title": "Important Information",
                                    "subtitle": "",
                                    "src": "${test2video}",
                                    "autoplay": true
                                }
                            }
                        }
                    }
                },
                "2": {
                    "position": {
                        "x": 0,
                        "y": 4,
                        "rowSpan": 4,
                        "colSpan": 6
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "ComponentId",
                                "value": "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/myRG/providers/microsoft.insights/components/myWebApp"
                            }
                        ],
                        "type": "Extension/AppInsightsExtension/PartType/AppMapGalPt",
                        "settings": {},
                        "asset": {
                            "idInputName": "ComponentId",
                            "type": "ApplicationInsights"
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
                            "relative": "24h"
                        },
                        "displayCache": {
                            "name": "UTC Time",
                            "value": "Past 24 hours"
                        },
                        "filteredPartIds": [
                            "StartboardPart-UnboundPart-ae44fef5-76b8-46b0-86f0-2b3f47bad1c7"
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
