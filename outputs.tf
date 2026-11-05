output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "igw_id" {
  description = "The ID of the Internet Gateway" 
  value       = module.vpc.igw_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"      
  value       = module.subnets.public_subnet_ids 
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"     
  value       = module.subnets.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"        
  value       = module.nat.nat_gateway_ids      
}

output "eip_ids" {
  description = "List of EIP IDs"
  value       = module.nat.nat_eip_ids
  }

output "public_route_table_ids" {
  description = "List of public RT IDs"
  value       = module.routes.public_route_table_ids
}

 output "private_route_table_ids" {
   description = "List of private RT IDs"
   value       = module.routes.private_route_table_ids
 }
