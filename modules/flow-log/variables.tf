variable "vpc_id" {
  description = "The ID of the VPC to monitor"
  type        = string
  default     = null
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

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "enable_flow_log" {
  description = "Enable or disable VPC Flow Logs"
  type        = bool
  default     = false
}
