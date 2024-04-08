// terraform doesn't let you have undeclared vars used from a tfvars file but no variable declaration
// we link this file into each component
// from the component dir: `ln -s ../../environments/variables.tf variables.tf`


variable "law_name" {
  description = "Name of the Target Log Analytics Workspace"
}

variable "costpergb" {
  description = "Data Ingestion Cost Per GB in £"
  default     = "1.92"
}
