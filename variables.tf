variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway (true) or one per AZ (false)"
  type        = bool
  default     = true
}

variable "public_destination_cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_destination_cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
}
variable "map_public_ip_on_launch" {
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
}

variable "tenancy" {
  description = "Either default or dedicated. Use default unless authorized to create a dedicated intance or host VPC."
  type = string
  default = "default"
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
  default = false
}

variable "enable_private_eks_tags" {
  description = "Enable tagging for private EKS subnets"
  type = bool
  default = false
}

variable "traffic_type" {
  description = "The type of traffic to log (ACCEPT, REJECT, ALL)"
  type        = string
  default     = "ALL"
}

variable "log_destination_type" {
  type    = string
  default = "s3"
}
variable "log_destination" {
  description = "For S3: arn:aws:s3:::my-bucket-name"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs for the VPC"
  type        = bool
  default     = false
}

variable "public_subnet_newbits" {
  description = "Additional bits added to the VPC CIDR prefix for public subnet sizing. 4 produces /20 from a /16 VPC."
  type        = number
  default     = 4
}

variable "private_subnet_newbits" {
  description = "Additional bits added to the VPC CIDR prefix for private subnet sizing. 4 produces /20, 3 produces /19, from a /16 VPC."
  type        = number
  default     = 4
}

variable "private_subnet_offset" {
  description = "Starting cidrsubnet netnum index for private subnets. Null auto-computes to length(azs). Override when changing private_subnet_newbits to avoid CIDR overlap with public subnets."
  type        = number
  default     = null
}
