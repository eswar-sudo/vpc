resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = { 
    Name = "${var.vpc_name}-public-route-table" 
   }
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = var.public_destination_cidr_block
  gateway_id = var.igw_id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ids)
  subnet_id = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count = length(var.azs)
  vpc_id = var.vpc_id
  tags = { 
    Name = "${var.vpc_name}-private-route-table-${var.azs[count.index]}" 
   }
}

resource "aws_route" "private_nat" {
  count = length(var.private_subnet_ids)
  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = var.private_destination_cidr_block
  nat_gateway_id = var.nat_gateway_ids[var.single_nat_gateway ? 0 : count.index]
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
