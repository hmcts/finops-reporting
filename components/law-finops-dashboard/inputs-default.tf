variable "location" {
  default = "uksouth"
}

variable "product" {
  default = "mgmt"
}

variable "expiresAfter" {
  description = "Date when Sandbox resources can be deleted. Format: YYYY-MM-DD"
  default     = "3000-01-01"
}