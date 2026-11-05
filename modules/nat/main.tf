locals {
  nat_count        = var.regional_nat ? 1 : var.single_nat_gateway ? 1 : length(var.public_subnet_ids)
  nat_subnet_index = var.regional_nat ? 0 : var.single_nat_gateway ? 0 : null
}

resource "aws_eip" "nat" {
  count  = local.nat_count
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = local.nat_count

  allocation_id = aws_eip.nat[count.index].id

  subnet_id = var.public_subnet_ids[
    local.nat_subnet_index != null ? local.nat_subnet_index : count.index
  ]

  tags = {
    Name = "${var.vpc_name}-nat-gw-${count.index}"
    Mode = var.regional_nat ? "regional" : var.single_nat_gateway ? "single" : "multi-az"
  }
}
