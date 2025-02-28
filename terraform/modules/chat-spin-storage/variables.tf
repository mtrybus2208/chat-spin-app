variable "environment" {
  type        = string
  description = "Environment name"
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-2"
} 