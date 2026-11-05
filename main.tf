module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  region    = var.region
  vpc_name  = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tenancy = var.tenancy
}
  
module "subnets" {
  source   = "./modules/subnets"
  vpc_id   = module.vpc.vpc_id
  azs      = var.azs
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_public_eks_tags  = var.enable_public_eks_tags
  enable_private_eks_tags = var.enable_private_eks_tags
  public_subnet_newbits   = var.public_subnet_newbits
  private_subnet_newbits  = var.private_subnet_newbits
  private_subnet_offset   = var.private_subnet_offset
}

module "nat" {
  source              = "./modules/nat"
  public_subnet_ids   = module.subnets.public_subnet_ids
  single_nat_gateway  = var.single_nat_gateway
  vpc_name            = var.vpc_name
}

module "routes" {
  source           = "./modules/routes"
  vpc_id           = module.vpc.vpc_id
  vpc_name         = var.vpc_name
  azs              = var.azs
  igw_id           = module.vpc.igw_id
  nat_gateway_ids  = module.nat.nat_gateway_ids
  single_nat_gateway  = var.single_nat_gateway
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  public_destination_cidr_block  = var.public_destination_cidr_block
  private_destination_cidr_block = var.private_destination_cidr_block
}

module "flow_log" {
  source               = "./modules/flow-log"
  enable_flow_log      = var.enable_flow_logs 
  vpc_id               = module.vpc.vpc_id
  traffic_type         = var.traffic_type
  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination
  region               = var.region
  tags                 = var.tags
}
