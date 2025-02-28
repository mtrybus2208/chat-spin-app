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

variable "connections_table_name" {
  type        = string
  description = "Name of the DynamoDB table storing connection information"
}

variable "connections_table_arn" {
  type        = string
  description = "ARN of the DynamoDB table storing connection information"
}
 