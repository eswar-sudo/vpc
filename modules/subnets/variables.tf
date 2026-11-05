variable "vpc_id" {
  type = string 
}

variable "azs" { 
  type = list(string)
 }

variable "vpc_cidr" { 
  type = string 
}

variable "vpc_name" {
  type = string
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "eks_alb_tag-private" {
  description = "A map of tags to apply tag for private EKS subnets"
  type = map(string)
  default = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

variable "eks_alb_tag-public" {
  description = "A map of tags to apply tag for public EKS subnets"
  type = map(string)
  default = {
    "kubernetes.io/role/elb" = "1"
  }
}

variable "enable_public_eks_tags" {
  description = "Enable tagging for public EKS subnets"
  type = bool
}

variable "enable_private_eks_tags" {
  description = "Enable tagging for private EKS subnets"
  type = bool
}

variable "public_subnet_newbits" {
  description = "Additional bits added to the VPC CIDR prefix length to size public subnets. 4 produces /20 from a /16 VPC."
  type        = number
  default     = 4
}

variable "private_subnet_newbits" {
  description = "Additional bits added to the VPC CIDR prefix length to size private subnets. 4 produces /20, 3 produces /19, from a /16 VPC."
  type        = number
  default     = 4
}

variable "private_subnet_offset" {
  description = "Starting cidrsubnet netnum index for private subnets. Null auto-computes to length(azs) to preserve the pre-existing default layout. Set explicitly when using a different private_subnet_newbits to avoid overlap with public subnets."
  type        = number
  default     = null
}
