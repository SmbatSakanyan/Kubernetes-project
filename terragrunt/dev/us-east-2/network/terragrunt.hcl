terraform {
  source = "../../../../modules/infrustructure-modules/network"
}

include "root" {
  path = find_in_parent_folders()
}


inputs = {
  region = "us-east-2"
  name   = "my-dev-vpc"
  cidr = "10.0.0.0/16"
  azs = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  cluster_name    = "testcluster1"
}