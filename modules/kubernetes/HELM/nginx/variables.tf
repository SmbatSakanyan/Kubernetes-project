variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_certificate_authority_data" {
  default = ""
}

variable "cluster_endpoint" {
  default = ""
}

variable "cluster_name" {
  default = ""
}
