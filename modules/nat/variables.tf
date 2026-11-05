variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for NAT gateways."
}
 
variable "single_nat_gateway" {
  type        = bool
  description = "If true, deploy only one NAT Gateway. Ignored if regional_nat=true."
  default     = false
}
 
variable "regional_nat" {
  type        = bool
  description = "If true, deploy a single regional-level NAT Gateway. Takes precedence over single_nat_gateway."
  default     = false
}
 
variable "vpc_name" {
  type        = string
  description = "Name prefix for tagging NAT resources."
}
