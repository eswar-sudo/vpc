provider "aws" {
  region = var.region
}

resource "aws_flow_log" "vpc_flow_log" {
  count = var.enable_flow_log ? 1 : 0
  
    log_destination      = var.log_destination
    log_destination_type = var.log_destination_type
    traffic_type         = var.traffic_type
    vpc_id               = var.vpc_id
    tags                 = var.tags
}
