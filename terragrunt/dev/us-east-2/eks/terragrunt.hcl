terraform {
  source = "../../../../modules/infrustructure-modules/cluster"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  cluster_name    = "testcluster1"
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids  = dependency.vpc.outputs.private_subnets
}

dependency "vpc" {
  config_path = "../network"

  mock_outputs = {
    private_subnets = ["subnet-1234", "subnet-5678", "subnet-91011"]
    vpc_id = "vpcid"
  }
}
