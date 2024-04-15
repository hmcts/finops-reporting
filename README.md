# finops-reporting
Repository that contains FinOps related information for reporting.

# File uploads
Upload files into [here](https://github.com/hmcts/finops-reporting/tree/master/file_uploads), once a file(s) has been uploaded into master branch, the pipeline will automatically add the new content to the relevant Storage Account.

Similar process if you also want to remove any of the files found in [file_uploads](https://github.com/hmcts/finops-reporting/tree/master/file_uploads)

# Log Analytics Workspace FinOps Dashboard

A new component called law-finops-dashboard with separate stages has been added to the Azure DevOps pipeline. This will generate dashboards within the corresponding environment's log analytics workspace. These dashboards offer a detailed breakdown of costs per resource, resource group, resource, and log type.

The dashboards will be created in their own dedicated Resource Group.

The properties and the functions of the dashboard are defined within the dash.tpl file. The quickest way of generating this file for a new dashboard is to create the dashboard manually on test dashboard via the Azure portal and then export the configuration for reuse as code. The exported configuration can be parameterized for efficient reuse across multiple environments. Inspect the dash.tpl file and the dashboard_properties code block on the main.tf file for real examples of how this is done.
