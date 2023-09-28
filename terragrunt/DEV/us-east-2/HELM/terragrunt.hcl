terraform {
  source = "../../../../modules/kubernetes/HELM/nginx"
}

inputs = {
  region = "us-east-2" 
  cluster_endpoint = dependency.eks.outputs.cluster_endpoint
  cluster_certificate_authority_data = dependency.eks.outputs.cluster_certificate_authority_data
  cluster_name = dependency.eks.outputs.cluster_name
}

dependency "eks" {
  config_path = "../EKS"
  // mock_outputs = {
  //   cluster_endpoint ="clusterendp"
  //   cluster_certificate_authority_data =""
  //   cluster_name = ""
  // }
}
