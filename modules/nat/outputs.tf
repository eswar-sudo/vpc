output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs created."
  value       = aws_nat_gateway.nat[*].id
}

output "nat_eip_ids" {
  description = "List of EIP allocation IDs for NAT Gateways."
  value       = aws_eip.nat[*].id
}

output "nat_mode" {
  description = "Effective NAT mode (regional, single, or multi-az)."
  value       = var.regional_nat ? "regional" : var.single_nat_gateway ? "single" : "multi-az"
}
