terraform {
  source = "../../../../modules/kubernetes/argocd"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  region = "us-east-2" 
  cluster_endpoint = dependency.eks.outputs.cluster_endpoint
  cluster_certificate_authority_data = dependency.eks.outputs.cluster_certificate_authority_data
  cluster_name = dependency.eks.outputs.cluster_name
}

dependency "eks" {
  config_path = "../eks"
}

// dependency "ingress" {
//   config_path = "../ingress"
// }