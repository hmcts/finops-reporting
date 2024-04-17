# finops-reporting
Repository that contains FinOps related information for reporting.

# File uploads
Upload files into [here](https://github.com/hmcts/finops-reporting/tree/master/file_uploads), once a file(s) has been uploaded into master branch, the pipeline will automatically add the new content to the relevant Storage Account.

Similar process if you also want to remove any of the files found in [file_uploads](https://github.com/hmcts/finops-reporting/tree/master/file_uploads)

# Log Analytics Workspace FinOps Dashboard

A new component called law-finops-dashboard with separate stages has been added to the Azure DevOps pipeline. This will generate dashboards within the corresponding environment's log analytics workspace. These dashboards offer a detailed breakdown of costs per resource, resource group, resource, and log type.

The dashboards will be created in their own dedicated Resource Group.

The properties and the functions of the dashboard are defined within the dash.tpl file. The quickest way of generating this file for a new dashboard is to create the dashboard manually on test dashboard via the Azure portal and then export the configuration for reuse as code. The exported configuration can be parameterized for efficient reuse across multiple environments. Inspect the dash.tpl file and the dashboard_properties code block on the main.tf file for real examples of how this is done.

Below are the links to the set of dashboards which have been created using this pipeline.

QA - https://portal.azure.com/#@hmcts.net/dashboard/arm/subscriptions/7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c/resourcegroups/law-finops-dashboard-test-rg/providers/microsoft.portal/dashboards/hmcts-qa-law-finops-dashboard

Non Prod - https://portal.azure.com/#@hmcts.net/dashboard/arm/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourcegroups/law-finops-dashboard-dev-rg/providers/microsoft.portal/dashboards/hmcts-nonprod-law-finops-dashboard

Prod - https://portal.azure.com/#@hmcts.net/dashboard/arm/subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourcegroups/law-finops-dashboard-prod-rg/providers/microsoft.portal/dashboards/hmcts-prod-law-finops-dashboard

Sandbox - https://portal.azure.com/#@hmcts.net/dashboard/arm/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourcegroups/law-finops-dashboard-sbox-rg/providers/microsoft.portal/dashboards/hmcts-sandbox-law-finops-dashboard

## Updating the Cost Per GB

The costs are determined through a numerical calculation, necessitating the adjustment of the cost per GB whenever necessary. This value, pertaining to the data ingested into the log analytics workspace, is configured within the variables.tf file available at this link: https://github.com/hmcts/finops-reporting/blob/master/environments/variables.tf. Any future updates or changes to this value, prompted by alterations in Microsoft's pricing or other factors, should be made through this file.

## Further Information

Further information on this solution can be found [here](https://medium.com/@mbnarayn/itemising-the-costs-for-your-azure-log-analytics-workspace-0522ff05df95).
