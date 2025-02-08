variable "environment" {
  type = string
}

variable "prefix" {
  type = string
}


variable "stage" {
  type = string
}

variable "region" {
  type        = string
  description = "AWS region identifier."
  default     = "us-east-2"
  validation {
    condition     = can(regex("^[a-z-]+-[0-9]$", var.region))
    error_message = "Must be a valid AWS region identifier."
  }
}
 