// terraform doesn't let you have undeclared vars used from a tfvars file but no variable declaration
// we link this file into each component
// from the component dir: `ln -s ../../environments/variables.tf variables.tf`


variable "law_name" {
  description = "Name of the Log Analytics Workspace"
}

variable "law_resource_group" {
  description = "Resource Group on which the Log Analytics Workspace Resides"
}
variable "law_subscription_id" {
  description = "Subscription ID of the Log Analytics Workspace"
}

variable "costpergb" {
  description = "Data Ingestion Cost Per GB in £"
  default     = "1.92"
}
