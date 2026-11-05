locals {
  # Compute the minimum cidrsubnet netnum index for private subnets that is
  # guaranteed not to overlap with any of the public subnets, regardless of
  # whether the two newbits values differ.
  #
  # cidrsubnet carves a prefix into 2^newbits equal-sized blocks.  When
  # public_subnet_newbits != private_subnet_newbits the block sizes differ, so
  # the naive "offset = number of AZs" assumption breaks:
  #
  #   private_newbits > public_newbits  (private subnets are *smaller*)
  #     Each public block occupies 2^(private−public) private-sized blocks.
  #     safe_offset = length(azs) × 2^(private−public)
  #
  #   private_newbits <= public_newbits  (private subnets are same size or *larger*)
  #     Each private block covers 2^(public−private) public-sized blocks.
  #     safe_offset = ⌈length(azs) / 2^(public−private)⌉
  #
  # When newbits are equal delta=0, pow(2,0)=1, and safe_offset reduces to
  # length(azs) — identical to the original hard-coded behaviour.
  _newbits_delta = var.private_subnet_newbits - var.public_subnet_newbits
  _safe_offset = local._newbits_delta >= 0 ? (
    length(var.azs) * floor(pow(2, local._newbits_delta))
  ) : (
    ceil(length(var.azs) / pow(2, -local._newbits_delta))
  )

  # If the caller supplied an explicit offset, honour it; otherwise use the
  # computed safe minimum.  The precondition on aws_subnet.private rejects
  # explicit values that would still cause overlap.
  private_offset = var.private_subnet_offset != null ? var.private_subnet_offset : local._safe_offset
}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.public_subnet_newbits, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
    {
      Name = "${var.vpc_name}-public-subnet-${var.azs[count.index]}"
    },
    var.enable_public_eks_tags ? var.eks_alb_tag-public : {}
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.private_subnet_newbits, count.index + local.private_offset)
  availability_zone = var.azs[count.index]
  tags = merge(
    {
      Name = "${var.vpc_name}-private-subnet-${var.azs[count.index]}"
    },
    var.enable_private_eks_tags ? var.eks_alb_tag-private : {}
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
    precondition {
      condition     = local.private_offset >= local._safe_offset
      error_message = "private_subnet_offset (${local.private_offset}) would create CIDR overlap with the public subnets. For public_subnet_newbits=${var.public_subnet_newbits}, private_subnet_newbits=${var.private_subnet_newbits}, and ${length(var.azs)} AZ(s) the minimum safe offset is ${local._safe_offset}."
    }
  }
}
