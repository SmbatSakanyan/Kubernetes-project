variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "cluster name"
  default     = ""
  type        = string
}

variable "vpc_id" {
  default = ""
}

variable "subnet_ids" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}
