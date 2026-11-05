variable "vpc_id" { 
  type = string
 }

variable "public_subnet_ids" { 
 type = list(string) 
 }

variable "private_subnet_ids" { 
 type = list(string) 
 }

variable "igw_id" { 
 type = string 
 }

variable "nat_gateway_ids" {
 type = list(string) 
 }

variable "single_nat_gateway" { 
 type = bool 
 }

variable "azs" { 
 type = list(string) 
 }

 variable "vpc_name" {
  type = string
}

variable "public_destination_cidr_block" {
  type = string
}

variable "private_destination_cidr_block" {
  type = string
}
