variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "tenancy" {
  description = "Either default or dedicated. Use default unless authorized to create a dedicated instance or host VPC."
  type        = string
  default     = "default"
}
